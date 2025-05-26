Return-Path: <linux-kselftest+bounces-33781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82558AC3E92
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD7F177232
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D91FAC4E;
	Mon, 26 May 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFdGv/CE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3431FA14E;
	Mon, 26 May 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258942; cv=none; b=d+KOEWEWFohijRGxYy+H6/v/8342QHfCuhQeek8h8tEWlLoskh7lPAM9lInp/+W41Mm5rkPiYDq0MuCAZwHpTmQXB5cx+dGauY8hwLUxqYNund8n4PIAd/+pqhiDPqbTN8cbLUGhRdUBSNDz6VRKYYoBT4Vj11n/ifoTHD80gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258942; c=relaxed/simple;
	bh=wZGfiWYVYSInJYNXkga0gk8tFNqCzxPMMLGzyZzTFy4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dF2hb2xkizNB1bJ2AjXHsjvE+9CCL54ydYrAjZmdzb1CNaYOnIvgeY8RJX3mmP+A1T2MCO38sSOoz2kFrxVPpgbxIy8TRCEpAPHcot6gAddZUWxu5Q3+g5Uo9MCb941dR7hJkcBcsOUWCDgsxsMjnLsk+9j9nQm/YCopzRaoDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFdGv/CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30424C4CEE7;
	Mon, 26 May 2025 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748258941;
	bh=wZGfiWYVYSInJYNXkga0gk8tFNqCzxPMMLGzyZzTFy4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lFdGv/CEZw1hKNeDE0Ks7bL79xRdXrXWHwyJ/sqNw1dwFFuOwn0P2TnrImlv7RoQg
	 ugS8p7xMTaFRTnQhI6iwtssQscNCg2o74IsqPtujXvBjE0ZC59C5F0ra/ORDzUagBL
	 Do5HmR7FxiX4TVwBPvgtL5KqejyOqbnDY2KszgIUhXlvuaZnD3yEsxD/uIdARFLw36
	 kM6IF5DD14CiWxILs3BiMiWrXuG9uIXq+GW9C4j3d2ZSjU/6SSmdDsSr66rlWGjXQR
	 Y0EYYwEEccwxKoZF+fIk6/C6FQOhU8aQWymeZLPCx2YtpkcQfEuDmMxeOtor47Z8+C
	 4zGb9qaWRvOIw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 13:28:49 +0200
Message-Id: <DA622GQOFB4B.2MDK03ECPO3DA@kernel.org>
Subject: Re: [PATCH v10 1/5] rust: retitle "Example" section as "Examples"
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Michal Rostecki"
 <vadorovsky@protonmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Waiman Long" <longman@redhat.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Arnd Bergmann" <arnd@arndb.de>, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-1-6412a94d9d75@gmail.com>

On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> This title is consistent with all other macros' documentation,
> regardless of the number of examples contained in their "Examples"
> sections.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

