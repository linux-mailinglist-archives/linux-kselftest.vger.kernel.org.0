Return-Path: <linux-kselftest+bounces-29152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D85A63417
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 06:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0D03B1221
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DD14830A;
	Sun, 16 Mar 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsGC+OFf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F728E8;
	Sun, 16 Mar 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742101308; cv=none; b=V8Fhh7PVqF4GPwK/NAFF7TyrIME0B/Vj1nbho5IJFpjzaUiEFbe/jjDvJ82hNHj0nTjPhSFZCLgQ6XU7lTAAHHJu1EsGs2EZMqwj6iBgs/Wk2kYeogFEmDeDyymrxFSNYo2e1yAE6stEcjBI+RwnXWa7fua1jjGs6PubeXFGxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742101308; c=relaxed/simple;
	bh=+OMWntMpCD/WX30cA0JDfWIUfcmN5hDg+0udFVft9IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNDTKdefAjgtX1ORuroon0A+s2W49JE78jvs74rWkQcFk9uGGQ+PqfeMQVIPbv1wcUUJ+TEgeN1gjv/SiOsR6/sIDV7cnSraz8MK8OHw1Idki6yiDKcV7TU1ilS4v3sCWqRHly9KrGljblu9Z0Bh4Qsiat6ag9i9dvnT7Iy+PNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsGC+OFf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c081915cf3so440185885a.1;
        Sat, 15 Mar 2025 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742101305; x=1742706105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRN1l7bFTxbNZCjx7qqsa9V8PASVLov06V9cKZ7rsUs=;
        b=SsGC+OFfgVD+vvj2t88GhzDaAmKifMJLGS2rtIJWCGAADY/gg+1MwlirRevhQ8wp8o
         farcOugGhKDlEX+xjJJlzT51wa9rGGnkganelhiiKdudQebfavqpbJqeSXt5E7W9E9kE
         dZI6pheDYmXSE0XLMQKQwnlM2FeMXGNnuujy8Cz6RQbPS/bMFC8U+FOdpxy7cbPu53BX
         55SDc74dUxFcMUzkXM1hchjKTRRYuMChwhtPGe8AWYy7bAJhIDbP+8G5GhcpYGM9s/Se
         PfBlse48+vkFoRv/xR7bMM9618HClGM3yQ91KcPTzavJWAOV/en6Exsms3cDVppDHYG6
         QzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742101305; x=1742706105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRN1l7bFTxbNZCjx7qqsa9V8PASVLov06V9cKZ7rsUs=;
        b=knKcyDYvvr2jGSQq6zRo4p67hqP8CeJe24ZBMofuCUuWoR9+mjJMrgYhWiX4f2WHN5
         a2ziFarMpfhZ+7H+XUD8HQfTwgGlk2GzK1gf73vUZGOR1ClhOrqJ5XQ6VhJCWzFMsxJ1
         1mlQQDR2F7CREnB1LMgqSN9EGhscSF+4g4E6Hk3Km3hrzubrc8GcZSaIlhzz0iK4oBqk
         1uiJ4msQNM9+7LfBATiMqJ4miLtkbIb3T0f/GAreehSqI9mlDfxW59hy70rZfWoV45iV
         Qoj6OLeotlVdI9s0cVwsk2/wzT4L2g6oeDQBXmkXsYQCIHpj9Z0BGHCfLdHzHtSEfXb8
         2yLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV76t1RMVNEBK7rMyOyFzEg4+cFxJhyyn7JMm4Qqul71uKvCXu0HvDBlDnOaZhw3VH3NJJDkpoJL37BNhPzGYM=@vger.kernel.org, AJvYcCWT/aSbmAym4N0JzswwPZkK/ha0lZFlJusaIcTEpzyg0SqmEvIsl/sMPi/lNk2UJRIvcR2vCKnT5JuPBlo=@vger.kernel.org, AJvYcCWxYe2WKooGmu5spQ/wtt8XPI2J4dSxIsFXQvnlj9iybRGktvzv9I0FgXngZSEyA56qtsRrOQgL54CXULSU@vger.kernel.org, AJvYcCX5irkpivtRehg3qPE5cKH435cXBmFmvG0AS0sHwsWiSYPFqJmwZ8ffxAcssXzMvcR5M2pOmjaB8no9@vger.kernel.org, AJvYcCXMA1HYlNYXZNmByb3iodljVKwhHRQIXoiw72/PMCY/OoOuVn3bR4I/KFEbNMoqBhvcVnylt+31M0Yw9Bix@vger.kernel.org, AJvYcCXbf93QD9obnnyJQZAwLjgVmB/TVb0lD0gT5kWJ1TdUXpcF7rskBsraBQg8U1W5IAg5cpfaiUd5zuaZmWrjlCGY@vger.kernel.org, AJvYcCXeEoYSBs7up+F8WEdSnKtB8IlBxlltCIT/6RAHAyeJ063iEyX7fquCAG+FL5eWbjKcZsFQ544SfRa5@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYu6F8lVS3vLYlXglCdBHYKihn1s+0rB7pH0YE8mT6sItEFS7
	MKyQ7AGWH9IJUlvec3WBvkvQIQ+PeyJfobjFhZm76ZROKpMzbq17
X-Gm-Gg: ASbGncsxpxcy2aYX/qbPoyWSJOeimOjUhF43r9oCWLamtMQehTD5Mk0+zOcRRQf3SYs
	beBZ1DcBbpcqlt1AIR4BDuCwQJg4aADnnLzfqtFI/+gVjaQGCrCzvO4EGnaevuhmNL3noN98QUs
	FiOvPSiAIDW8+uCqCVxQ/InE9+dUNCXYQFr5WPLd+2DjEclk/xkg8L0N4YQp6TeLgMttvWnGnul
	AeBEDaBSmKZ9tMdBiOKYcvr7gIqLFJLTc+StvY3ABz58Tq4eZV6BtegSe9rO5cguZXqrVHREs30
	ua0AdPATGxzZ5qmDyTeopfS9e3FRWeK9gQVzED3dCEpnmiP943rmJgPASJxx3Ps9V45m4K9alzn
	POJWenDOQiUVTEdKz6mlT4DbVWU6Ojvno7X4=
X-Google-Smtp-Source: AGHT+IFHwjAwXc5ecCOT4zktz/2Ee2JBQsplxjcbO2uUgpx2D3hnYjMZgDmGYY4KWHDG3PBAwASWEQ==
X-Received: by 2002:a05:620a:450c:b0:7c5:562d:ccfa with SMTP id af79cd13be357-7c57c8fc954mr1158323485a.36.1742101304992;
        Sat, 15 Mar 2025 22:01:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c6fafcsm446035585a.25.2025.03.15.22.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 22:01:44 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id A8DF41200043;
	Sun, 16 Mar 2025 01:01:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 16 Mar 2025 01:01:43 -0400
X-ME-Sender: <xms:N1vWZ8_9TRjCl_errGCCNAZe2iKH1MYNvzQhtBAySLp9kafjcUjbqw>
    <xme:N1vWZ0snBzC60kufeTIDNADW9ulpI0un8rVFw2nsyNYPIx6D9UXRtrMwSjKN8hiN1
    5APefBecC--e2zyTw>
X-ME-Received: <xmr:N1vWZyB13RpGsY6XLhZVjzIUCMYGSu6TsTF4amyXy3nek4EzDzk4ccdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeehjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfh
    hjrghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    grrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhr
    ohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprh
    hothhonhdrmhgv
X-ME-Proxy: <xmx:N1vWZ8cK6WXUKuqzUUJfycM7hb5sozHGSlFYIqjs0yLmJ4UBSpYIMQ>
    <xmx:N1vWZxMloIGTET7Ixr7_6rBz3KWKwC6__tyl8ircrEnQR4Mq_1a3Lg>
    <xmx:N1vWZ2l36TrwFyCoEfCHjTMC_3cQqBfq9QMLrAHTtU0d1R2MVnN7iA>
    <xmx:N1vWZzu_GWynKmxcGM5Cwm3RBsdfR1_Jg-EiV9KEH149rG6env9XSA>
    <xmx:N1vWZ_s62qUn-tEovp0fn-dyMSG8cY8PPJKbInsrx-It4iwuCC5aYFu8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 01:01:42 -0400 (EDT)
Date: Sat, 15 Mar 2025 22:01:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
Message-ID: <Z9ZbNY2XR10vt3Ro@Mac.home>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
 <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com>

On Sat, Mar 15, 2025 at 08:17:30AM -0400, Tamir Duberstein wrote:
[...]
> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index 40d1bd13682c..f9459694cbdc 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
>      const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
>  
>      fn index(&self) -> usize {
> -        self.0.data as usize
> +        crate::expose_provenance(self.0.data)

Even though of_device_id::data was defined as `void *`, but in Rust we
use it to store index, see kernel::device_id::{IdTable::info(),
IdArray::new()}. Hence we should use self.0.data.addr() here.

Regards,
Boqun

>      }
>  }
>  
[...]

