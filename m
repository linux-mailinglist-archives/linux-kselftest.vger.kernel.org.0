Return-Path: <linux-kselftest+bounces-21324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105EB9B9A3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916871F22F9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F791E2612;
	Fri,  1 Nov 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exGovcmf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84F1547DC;
	Fri,  1 Nov 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496585; cv=none; b=PsWN39mixXy6s/KebXlrD8lZOhNgcIo9+mdJo47FGE9zlcR2fFk7/pwh8+ymq6nJR5b2QCS+cg019D3BRlqlGXKIYvH2kdEkfC0nndBxC1fkGFI6D3HPzINQlWZmIK1kMxw7VcYKYKYg2nRNZIvDBA/51RSWB4X4BtIYt1/p1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496585; c=relaxed/simple;
	bh=wUv4Mmyden8QXixNRuHywr5j0xg1h8babFVNw+OZ6Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOiuYzH/htkrk3Gvu4f5Hls7FcN8oOYK7Tl9WkvXOBlLVUfDwXwODIeqj2OVyJSS78I8NrxY93ynlXb3fP9m12tZMI3AAuzdJz1Q7ebuVs7VjGcIhlBvcVAAleMRWbntFmCHZxCqnuI5XaKgwADMxDmALl1eOJ0SPZJ+kdJiRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exGovcmf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so15643886d6.1;
        Fri, 01 Nov 2024 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730496583; x=1731101383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6RqVmSnLlS+aTA+4ijNGjm2L+S42vaFccd3PBdWHCU=;
        b=exGovcmf5Eedqh81c752ZYWnxBTaZM23VoY41OeObVD5NNHIA52DwsGddEyzFyGUQE
         Dnx/ZSOsdFh6tFu/fKAenx0aSVeYanN436BISEc+9e/1goua+KiaWsbNnvyyp8cMY+Fy
         5cDGC0D4LUedAWDZwZhgmobDN5tYZTUtGR4pbmcSBmnQhUuWuvmCQUyp+3vPMK5ICGFb
         ni/Ofqu0C5HRZpJlyGiHxCFITR3MkQwJ6sHe44KX6oKbpyNHB8Rv2M+shjMZ1eVJ21sB
         Pc1UaGSWTM3dwNfTD2X4SmUKYF0neTQHVfwpSuqLaBcW59S+Lb9bUw3rp1vuX5mcuXuY
         2uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730496583; x=1731101383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6RqVmSnLlS+aTA+4ijNGjm2L+S42vaFccd3PBdWHCU=;
        b=EO7NeQW/hHzTbOm6QOTJOmyiEAwejBT91C/RkY5UjGKOKT4X9rgEOJPqO+PljUzvki
         CnyZo0oXY/kiMO/KCOA9nPD195XgORmLF9AUYK85Vx/l21+8c9I5UcaQPpXwph3owzzA
         VbCH11zvs1qu878BrSypeQxCakwV659Ll98s1A/9a3SwUPKXm/WMqywiFGTuLh30JX3l
         d8MJ6llovN+fUZJuXerpOIHFGtEr5BPw85ZGtlMZW2k1iEXO/9OAK7YDqkQTRpluPnle
         boYl99jwUNTIWQnK06LEmWpkIyNamvwggNmfLE5CHMXHT+kUDY96yht3aZ6jLQbS+thx
         x8HA==
X-Forwarded-Encrypted: i=1; AJvYcCVQSjo7tBNFbAMNVbO6XRahMwbKIWtFgupvE7zyFbpjVmOM+LY/q41qLLrukmt7qJiNg3KQg2iEcg72GGhtkFI=@vger.kernel.org, AJvYcCVk/s/FZ4VoaQ4LBJ234QcdZHid/UzGDuZG2WSUNQVnL6SlS2nY76y3P06r8xidElj1oVlOZig7sU5BYP4D2nRc@vger.kernel.org, AJvYcCWF/MzM+evfEycg0ADy/YoTGoezIOerN4J4fqUxrt3LphES7LZAIP5YoN17JQ6dbRQZiUFDieGhUCTGxNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL38zj2AzTYoAKTxBG/J8/6Vh8bsmlEFW30do78pXfckl6+2U3
	Tv2p4VkYVHkJIFFHG7gSWUVSC+JYhydymyx+D3kTNcqfRn1dDMpz
X-Google-Smtp-Source: AGHT+IHg6WfvVjXsdZ9cmM2dc/TNrHtqK2fwwM81+rrqESxKCi4tQDqTMFY8TEdHmsS0quOjMnzWHQ==
X-Received: by 2002:a05:6214:2e47:b0:6cc:41cb:4c6c with SMTP id 6a1803df08f44-6d35c1aeedfmr58433476d6.48.1730496582679;
        Fri, 01 Nov 2024 14:29:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35c73440esm13139686d6.63.2024.11.01.14.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:29:42 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 784FD1200043;
	Fri,  1 Nov 2024 17:29:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 01 Nov 2024 17:29:41 -0400
X-ME-Sender: <xms:RUglZ7TbCS-pn0w_fjxb_XLpfMkQxnOy9lWXgvBx0EqB8D8yXWbMbQ>
    <xme:RUglZ8xffMw00fieXW7voXJBA3hS_hM2rzl-Y9d-anZ5qMCcnKJ3Cyj51wmjhkJTr
    -zWYTqW7uNdgMsGPA>
X-ME-Received: <xmr:RUglZw1qdv4kMgMHUwxZWYeGHZf6DXwzEPdYbwV--LCQV3woV9P9MwhhRww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhsvgdrvgigphhoshhithhokeelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrvg
    hnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopehrmhhorghr
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    ohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RUglZ7BBkgqbyQJwGHJeTooJomjJ0EQGII8nPsf3Hk2odjYjKFXP5A>
    <xmx:RUglZ0jczVGMkeOXnFilCk6aFdH9OzhKSxqX8ojTUe_kYgb1WBMlVA>
    <xmx:RUglZ_oW1stnW4619jlhvPzMznM-o_AL31N4JKWn4ZtEhJEtO7I-rw>
    <xmx:RUglZ_j14Y86mgdQnXUIOeoN3Zx9jXIQH2cHoQxdxYaQWPiiYPwWcg>
    <xmx:RUglZ3RXgx9whNMXvTdasYdZaONS9nfEgNB6BJ3PTqJ4jCP4DqjTlghX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 17:29:40 -0400 (EDT)
Date: Fri, 1 Nov 2024 14:29:39 -0700
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
Subject: Re: [PATCH v4 3/3] rust: kunit: allow to know if we are in a test
Message-ID: <ZyVIQxTf1qkts1d_@Boquns-Mac-mini.local>
References: <20241101064505.3820737-1-davidgow@google.com>
 <20241101064505.3820737-4-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101064505.3820737-4-davidgow@google.com>

On Fri, Nov 01, 2024 at 02:45:02PM +0800, David Gow wrote:
[...]
> +/// ```
> +/// // Import our mock naming it as the real module.
> +/// #[cfg(CONFIG_KUNIT)]
> +/// use bindings_mock_example as bindings;
> +///
> +/// // This module mocks `bindings`.
> +/// mod bindings_mock_example {
> +///     use kernel::kunit::in_kunit_test;
> +///     use kernel::bindings::u64_;
> +///
> +///     // Make the other binding functions available.
> +///     pub(crate) use kernel::bindings::*;
> +///
> +///     // Mock `ktime_get_boot_fast_ns` to return a well-known value when running a KUnit test.
> +///     pub(crate) unsafe fn ktime_get_boot_fast_ns() -> u64_ {

Clippy complains this `unsafe` pub function doesn't have a "# Safety"
section. Actually this function is not necessarily to be `unsafe`.

> +///         if in_kunit_test() {
> +///             1234
> +///         } else {
> +///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }

Need safety comments here,

> +///         }
> +///     }
> +/// }
> +///
> +/// // This is the function we want to test. Since `bindings` has been mocked, we can use its
> +/// // functions seamlessly.
> +/// fn get_boot_ns() -> u64 {
> +///     unsafe { bindings::ktime_get_boot_fast_ns() }

and here. If you make ktime_get_boot_fast_ns() safe, then no unsafe
block is needed here.

Regards,
Boqun

> +/// }
> +///
> +/// let time = get_boot_ns();
> +/// assert_eq!(time, 1234);
> +/// ```
> +pub fn in_kunit_test() -> bool {
> +    // SAFETY: kunit_get_current_test() is always safe to call from C (it has fallbacks for
> +    // when KUnit is not enabled), and we're only comparing the result to NULL.
> +    unsafe { !bindings::kunit_get_current_test().is_null() }
> +}
> +
>  #[kunit_tests(rust_kernel_kunit)]
>  mod tests {
> +    use super::*;
> +
>      #[test]
>      fn rust_test_kunit_example_test() {
>          assert_eq!(1 + 1, 2);
>      }
> +
> +    #[test]
> +    fn rust_test_kunit_in_kunit_test() {
> +        let in_kunit = in_kunit_test();
> +        assert!(in_kunit);
> +    }
>  }
> -- 
> 2.47.0.199.ga7371fff76-goog
> 

