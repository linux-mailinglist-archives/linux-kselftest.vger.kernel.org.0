Return-Path: <linux-kselftest+bounces-35336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB8ADFC79
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 06:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56C17FBDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C779188580;
	Thu, 19 Jun 2025 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="st3jnt91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297464C6C;
	Thu, 19 Jun 2025 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750307448; cv=none; b=rzbJXDpHR8KBTcydi8RVbbQtoa1UcIQkIyDZEMaHbgFQO0UklL6RlxAj7rrjKoXS8VMHd2TciLF4fjUUCZKizcDmbSThO9zhy+vWZI2GeLeZsYEdyda7N8T+KDY84LiXLNSXb4uw+P1ipJAxX9x2WZHki5q5OrbrXyweq8NRFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750307448; c=relaxed/simple;
	bh=RkszZ+4CO5HPbQ9OZvtEUSF9NCC9BO39xHiRDQcYuOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXxErcE2XJII65rlZQtYtPRivUkeTetKkEpSoQMxCjguGGWKtACEwebErdK5LNjD6ngnP3FUzFHysKyPDVDSc1badZ0EWGkrs3te8ahlqAN3aFPX4BxA+7Hwg1T2YOhXn+guZBM9lrosqNNxFXktDkoPDT+vhNHRA/24NHcuVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=st3jnt91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27403C4CEEA;
	Thu, 19 Jun 2025 04:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750307447;
	bh=RkszZ+4CO5HPbQ9OZvtEUSF9NCC9BO39xHiRDQcYuOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=st3jnt91uU/CnwTBt3Ahp147TRAwWb8pXbGypGoc/VymUwGTmYQFyEGs0i+qp2a/3
	 CdYe0pWv15pbDuWmiGZVS+qqHQLgE9hrCTr4WbxKRrnW4eUzCrETJ4UNgNkPpe9/Kr
	 oABPxYM5VCHVjAobpVLADv4N0m9WwFckCIQpuo8o=
Date: Thu, 19 Jun 2025 06:30:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Breno Leitao <leitao@debian.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
Message-ID: <2025061933-smog-breezy-90d6@gregkh>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com>
 <CAJ-ks9k0vAw9UHx-s9uD9u0LufvgnojtrFoG=AH40Gp9HnxEDg@mail.gmail.com>
 <CANiq72n4rr-S5NtFECxpd8FzkZvE8mg++p0qWDLK7+C0ru1Tew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n4rr-S5NtFECxpd8FzkZvE8mg++p0qWDLK7+C0ru1Tew@mail.gmail.com>

On Wed, Jun 18, 2025 at 07:04:11PM +0200, Miguel Ojeda wrote:
> On Wed, Jun 18, 2025 at 3:51 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > @Danilo Krummrich could you please have a look for nova?
> 
> Alice, Christian, Danilo, Greg, Tejun: it would also be nice to get
> Acked-by's for your (other) bits.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

