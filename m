Return-Path: <linux-kselftest+bounces-29151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B0A633C9
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 05:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5963A72EB
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE54642D;
	Sun, 16 Mar 2025 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnAKQvEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB42EBE;
	Sun, 16 Mar 2025 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742098525; cv=none; b=t/EKv+/TGK7xIO/D+5o7DAoKJrmpZTWc8tTmtnKkkWv4KsLmeO253WwG9qu19BzArFawNkSfQ02M1cAn133HRGG+8R+v0wQ/vCTUgFKp2EiBbUgPygQAP54m7g3Hn5vEWLPHNOrb798CYMg+Gk0Wydndlk62ipslP+NCS5fe9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742098525; c=relaxed/simple;
	bh=QdLPfHOpgg9eDBnJdTiWJNgY72yD73d61f//viDuw8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmVXkzGh2CMVjmOnCc2P3GXRtJFKRAfPgbQ+g97p6/pyokfpsQ//ZIa1FRKGjVeA8QjFCBSBCUMktVeK2d+7qnuMMaMMal2qqyXYiSzk0sfNHItD//lWTYWuNfEL/MYeNzm6Jx3vaPwagewg93U90a/31VE/KbCSVDOJi7PHTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnAKQvEm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471fe5e0a80so30657061cf.1;
        Sat, 15 Mar 2025 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742098523; x=1742703323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvMWMFB/hUHArUvcLdKUgOpO6qHWD0PVBQLUW1u7Ejk=;
        b=lnAKQvEmqO6V3UMzKpuWde7FAQ9SHo0krvEBvzmZOrk93kEok72R5HuKgjQTIFXIff
         sDskDPQLtNsIDtk//nhKU1wsHl2giMdRD9cgowm4hKCDCaKcXbVwHTwFfAkrQqt3qIlU
         AphaR7bpR9ej+tbLCCrHE9AVTTwyQqiRLHqMQ9HvhqfY95wiRFdScH6nJhMDLROb5Fjm
         f46zaEVvqtzzuBN979xqT8KoxqtSgnvOj15kTAFmVlA1jbWkDg9h2SEWtUHF1SV0BmKl
         C7RGSjubS/moPL1qeI9gxuJCD2r63s2uTA1vgw933H/2qZnY9uzykdSBeBVyBHMpO9kj
         M+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742098523; x=1742703323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvMWMFB/hUHArUvcLdKUgOpO6qHWD0PVBQLUW1u7Ejk=;
        b=WFZZsmsmMm1cq5ayVUwtdlrRVdUZd9zUEaAVQCy1v0OEK3sJBP/Xq7lKDbUz9d9tJh
         LGmZ36cfDvrtbuhm3Rl0mqT0n6If5vmXLtc+t5kfg2PwsNnaE0KpVXVYnPIBEej/QC8z
         bNg+bC6DINAOo5y3r3PrXS9OQPEs54OZF1dnUh7/bSGuLw2pv8xG5Xb6K3Ly/hDpnTTL
         0DrEw55L/I23K4bjG8X791wFYa66WNMC1T728Hqa/lUuG7Q4WXzCyoIThceDKYWJxHZc
         LzRU4YrKsWb2gZ9US3pQQzm0rDf0uXRQpoVsve8K19ih90wyIp2HGKo7YRzB3C1JqhoG
         9gxA==
X-Forwarded-Encrypted: i=1; AJvYcCUdAyjWSfW54Izp/bPMITqT9Yzgu/55JMhDEdswf83Fy+ODGgF7f70t2FfVcNrGdkopi1Pr9w4NM63Kzi38z5U=@vger.kernel.org, AJvYcCVhew7hPatRg6p3HvaVynSL64jTvIpAbZqJHXlBVKOBIRd77DH+kFHQPChbwdDGoLwJ5u7xcXJaxW5eAPMcqgfA@vger.kernel.org, AJvYcCVijVKT5M83kOgZXGLH1Z1YgEPVjApPGpeEAY6arLXvHyEXg+xBWAL7X107RxU88Q1V8epBVAK8tMvG@vger.kernel.org, AJvYcCVmNng+afYS1PIvhrusA1P4W18ZIueGW2b4ganFUME1PRsjVgDqlGIqFwmVB5NmK+yETcdolPmD/ONchg==@vger.kernel.org, AJvYcCW8oRLaC46zexVG+9GdjvvPNh0JVwMJUUDFH3S3JhM00QPlAffJ7jzvQyx1HyHdu77ZBbh30UTK679tCaDG@vger.kernel.org, AJvYcCXBSV8SgBA6BlWF1UwiC4Xjo6eJGLbuAicCGVx81kEQ9LoxESWLaktzyJ4qUTkUJdtBYtjTtutA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27zdavri3ylDsuEnJmWeSxs19OUi+xH5h4rokVtN4AocfYsrq
	oi4KaUsAfIk6kMzjf7jOkcmmytbgJqVFcIwJ7XBSCiKjSsie3JOy
X-Gm-Gg: ASbGnctN7/K5Mj1KS1UixK1xLSLPowrc2Hsu10quyV7l84Uyy3M1R9/MErBKn/ffSIB
	/OFk00EiXEdNa0FZZsFre4XnhZIxNYvvLcmjN7i2k0eYQd7HKO+4uc7HeqbPM3ksWOs23qdbhAd
	eLUDpTkGgXhG3uBHWV4E1NaU3KQzYefZbNVu2+a3dZ8PhyrAO/ETf5MoU+KIQ0Z/JVRz0gQm6Qm
	AY6JEGDu26OlsDQ/JfLW6WZshzSwGl38qJJQ6klLcaJWyZRc1v6FkyJKf2OWTgX49KQ+dvrtYHt
	SAyvxyGzZgCXIDn1SRow5xIUKi8RqetZWkCRQ0SHCkddyUoqz0+NTrmxnKIwD6LStZbdky0Haj7
	RZJNuck3hUSQTMP2EAikaWXVscK+N49Nc5jA=
X-Google-Smtp-Source: AGHT+IHQGwXgWbnPN8FsSKmsTkKfZ7JrACeBVWAlSeDsUZfAPOA+ndsuFpLSTHyePO2ANb/zmZmWlg==
X-Received: by 2002:ac8:5908:0:b0:476:89a8:f73f with SMTP id d75a77b69052e-476c81461damr122156681cf.21.1742098522990;
        Sat, 15 Mar 2025 21:15:22 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f3d0fsm40425921cf.59.2025.03.15.21.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:15:22 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B0BA1200043;
	Sun, 16 Mar 2025 00:15:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 16 Mar 2025 00:15:21 -0400
X-ME-Sender: <xms:WVDWZz8S9sMETK0Gd_5N8fXHJs4n8xWjajbCIY-NoW1NUhpsUp8zlQ>
    <xme:WVDWZ_t6NEDcYY62fyRQ4JbYVCKKLTGpR8i5Qsne2cozukfocdqkRrPpf7Ya67Lse
    sFdIaFBlFyNcaXnoQ>
X-ME-Received: <xmr:WVDWZxA3mn3aM1LfrI_-DcIG7jbx-JdYGzlOPK7TeQZ44P8NZ1rtfdS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcu
    oegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephe
    dugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeeh
    heehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmh
    gvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghonhhtrggtthesrghnthhonhhiohhhihgtkhgvhidrtghomhdprhgtphhtthhopegrrd
    hhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgih
    nhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhm
    vgdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsghr
    vghnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopegurghkrh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WVDWZ_c9xe9HPIhNQWLxpA6kt5nyaPiC_v2-cm_iod1Lt-0yJ6_BOw>
    <xmx:WVDWZ4MQn9rr62nGFnXBWTtnfbAvB9lScmQYKHcx006jFK8bwCKepw>
    <xmx:WVDWZxlWOlKlu6ZNxsMAzocZxfh6v7FQ58Cc4O7d9rxl6sYklRUQTg>
    <xmx:WVDWZyuw2usNk1kgRpbGpyrdn3xKRC1MpjzG6r_Xwm-AubA6J03ltA>
    <xmx:WVDWZytxuKC0J-PLthMIdPHgKbPF1p_OuuSpCMHYhVr_n7Ym1EAW1hw8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 00:15:21 -0400 (EDT)
Date: Sat, 15 Mar 2025 21:15:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@antoniohickey.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com,
	benno.lossin@proton.me, bhelgaas@google.com,
	bjorn3_gh@protonmail.com, brendan.higgins@linux.dev,
	dakr@kernel.org, davidgow@google.com, fujita.tomonori@gmail.com,
	gary@garyguo.net, gregkh@linuxfoundation.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org, ojeda@kernel.org,
	rafael@kernel.org, rmoar@google.com, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw
 [mut]`
Message-ID: <Z9ZQV7EbzeOPsUUU@Mac.home>
References: <67d4c74d.050a0220.66d0.b23d@mx.google.com>
 <010001959ce25be2-a436530e-858c-4da8-b823-24f98bad392b-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001959ce25be2-a436530e-858c-4da8-b823-24f98bad392b-000000@email.amazonses.com>

On Sun, Mar 16, 2025 at 02:57:15AM +0000, Antonio Hickey wrote:
> On Fri, Mar 14, 2025 at 05:18:17PM -0700, Boqun Feng wrote:
> > Besides, it'll be easy to review if you can split the changes into
> > multiple patches. Thanks!
> 
> 
> Hey Boqun,
> 
> Thanks for the review, do you think splitting this patch
> into a seperate patch for each file would be best?
> 

That'll be my suggestion. Although you could group a few changes
together for example, changes on rust/kernel/init.rs and
rust/kernel/init/macro.rs can be put into one patch. Thanks!

Regards,
Boqun

> Thanks,
> Antonio
> 

