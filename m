Return-Path: <linux-kselftest+bounces-21325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851D9B9A4B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4215283E63
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBF1E571D;
	Fri,  1 Nov 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkGTGYk/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4A1E47A5;
	Fri,  1 Nov 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497101; cv=none; b=u9WCkp9rig2DnslMRg9yV/FkBBMsRDq7/YIO8Rilgg88jRD1r724y2soUJwYjP1fwXUMqTiRwrV9mamjBgP2IOB48XfS4ySJw+SSccvh1plP8A1kxat76PGpBm5wiBtq7WPGExUtkApYZomnYCW05phykpCzweigf3e/12mHI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497101; c=relaxed/simple;
	bh=NaUGQoO+qua7rt17PrqWsXidf3yvC6bM0P7qWmzWNvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aiwp+prRCKvYaTswJOyxj58UJW28lnYG1G/q3wykIPMgOn2Jj3cDQHW7bcuYGQT6Vb+OMOHQplq0fKBWSM2mIVnGbiGyBSst5Ix1p5DSzys5fBvUhoNIH6EGaTCJHggZtZa7/ufSXG3qRzVyvaP5RqF5yQpGRs5D68UH4g6DS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkGTGYk/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460e6d331d6so15129581cf.2;
        Fri, 01 Nov 2024 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730497099; x=1731101899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCOILmRNqBE6ZWY1p4IX8uvti1SM8oZ7fsEHU+TvcSA=;
        b=CkGTGYk/XJ4M+jEfKLmfc3G65Gc5dXlCAcLst7nghrKqnsWDparsXJzSAUsEDo+wXN
         LFM3FLOygfMaZRTzKRD/CCKyKcFE8e+NHrkO2KP5lfMWCeRAtCQqGfV+nNvxTODQOpQZ
         JzsLkJ5TiVI05rbtBbb4gsYvRLbvfld2MXDhacKoLJC6QiL9Zkc+Qvw3EG8cIGQfNSmc
         +ulyImzzi4c3w+9yU/IyQY+kWkcfQ2aJwMsSSRkGlPyxKDPMplAFqexb9GSOYOJqata3
         NlBckCqUx1akpM5dKmmjBfRPPp2yBDjZBfqLYuOnyKBessBH49vfDzyepe5XK0xa6R9G
         zOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497099; x=1731101899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCOILmRNqBE6ZWY1p4IX8uvti1SM8oZ7fsEHU+TvcSA=;
        b=lcrGcxKnMtMDmoRJg7ZLIlU4FfNL0wxwa8G8Qk9rLCi90YkpqTbttKLX/9i12ZezsY
         z5h+YglJE0SfKJ7ivqS8YhDLRSCe8/afuZPG5cQPkT7eWLbOZwO+Hscwby0pvtqjjHal
         0CGmhC/BRIc3qahT0EYE17rLOkXrtiyNAH53AigZaS1DarD2g432+ezx3El5aIJr13QL
         FdwOA391FMeK9DFYddyU//hSA1NN0WMspdX0KZoORea7OY1La/3OVfK0xNFNhrVF1vUf
         ER10ENOtkLKwgtWMt8ysXGq+8FH1p4VRU2nP4QTZ01zaHVObjFU+IrbDtIebPgM6heyx
         5uJA==
X-Forwarded-Encrypted: i=1; AJvYcCViApLZf3xfOw2ibOQYZJm4Bc7reBxXGpFO5V0hqEf8SAHqAqjtP6zMmLvsCeNlEuoclrjeUFrArer8wGE=@vger.kernel.org, AJvYcCWXtL9Cl0lSDsBLbMPAPSdf6ERbtu9KKYcYf0ctMpkIFn6ASyE2qmOpR8pslFXRfBNTWegKvV6AMe26qQNPgbU=@vger.kernel.org, AJvYcCWcbUj7QuF4Yi1ZX0qBYC/mzoD+t2vKXB2KmWb79EEp4kHNDrymWCg6i+7l4x//6eHEhaaM0KA9VC+KY5GJOkuI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86B/zl3C6NSMI8Hg2NQJX51dlXIjYWWtkJDhhRG/N4e5b9FwJ
	Ull2HvEhvmY8QXaaVqPdMCMnCLGZB7K1gUxWfjtLXwhSeDmTlEbQ
X-Google-Smtp-Source: AGHT+IFzuAuuMva5coyqLPg9S15y8Mlaf80dpYp9sux05DwQgjZpyiJ8ElxROSwl3wxI07O7wq0IFA==
X-Received: by 2002:ac8:4e35:0:b0:462:c322:47b9 with SMTP id d75a77b69052e-462c32249bfmr21194581cf.17.1730497098666;
        Fri, 01 Nov 2024 14:38:18 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0893e3sm22421981cf.6.2024.11.01.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:38:18 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A1C701200043;
	Fri,  1 Nov 2024 17:38:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 17:38:17 -0400
X-ME-Sender: <xms:SUolZ67Zi6tFQeKLYrDAGgygskeNElk99V5waD3BD2Epu8Iw_lEIVw>
    <xme:SUolZz4ffIiMw4fjIG4bFoafs1Or_JQ34pfEempuwmnQ1ynOCM2OVhu6B69DupIBw
    ND1VZO9sI8UEOzyDg>
X-ME-Received: <xmr:SUolZ5dZcym49XMSNA-ceTX4wwhpeB0O_o_grNBmCoRasKdmWQbLnAgUCZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvg
    hnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghr
    nhepkeejgfdufefhiefggffhtdehgefgtdduvdekjeelffehueefffetteevgfefueejne
    cuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduie
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sghrvghnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopehrmh
    horghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtg
    hpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SUolZ3I7shbs8uYlTvA_--JMSUBThRNdym6H__rY5PKLeht3FhgyZA>
    <xmx:SUolZ-J_p7BK9E4_RDDjZL3nmk_CsYM4kPqTew2Q8FoxrOSaV7qiVg>
    <xmx:SUolZ4wbdRWtJHgTeccwd_MwD_YSUdupY-2vIFaaMdWWwqg9oQrdMg>
    <xmx:SUolZyIUSpnf6l39nX2cFK3c3EAi_5YlJ5TGIVCLVjs_YYMcPB_ePQ>
    <xmx:SUolZ1brqeYtkrotPzyhNGlOSSIcse4LCf7ne9eiTYAHJhOL8ygTmsyM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 17:38:17 -0400 (EDT)
Date: Fri, 1 Nov 2024 14:38:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZyVKSKUq_bKH5jn_@Boquns-Mac-mini.local>
References: <20241101064505.3820737-1-davidgow@google.com>
 <20241101064505.3820737-3-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101064505.3820737-3-davidgow@google.com>

On Fri, Nov 01, 2024 at 02:45:01PM +0800, David Gow wrote:
[...]
> @@ -273,3 +275,11 @@ macro_rules! kunit_unsafe_test_suite {
>          };
>      };
>  }
> +
> +#[kunit_tests(rust_kernel_kunit)]
> +mod tests {
> +    #[test]
> +    fn rust_test_kunit_example_test() {
> +        assert_eq!(1 + 1, 2);

Clippy reported:

ERROR:root:error: identical args used in this `assert_eq!` macro call
   --> ../rust/kernel/kunit.rs:348:20
    |
348 |         assert_eq!(1 + 1, 2);
    |                    ^^^^^^^^
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#eq_op
    = note: `-D clippy::eq-op` implied by `-D warnings`
    = help: to override `-D warnings` add `#[allow(clippy::eq_op)]`

but this lint doesn't make sense to me, I would say we just drop this
lint?

Regards,
Boqun

> +    }
> +}
[...]

