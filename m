Return-Path: <linux-kselftest+bounces-41569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B1B58E6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CE53B1BD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFCA2DFA25;
	Tue, 16 Sep 2025 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lv6xc298"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57102DCF5B
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003809; cv=none; b=idbuAg9gmDXA50r5GU8MwoqKjCbmfdUKSxu8nJwWeYgKnxI7gDSjSx+NB7Qv5Qx9Bn5amcNJiSuada0ILknOd5OA44IR1RBq6X0DI1t2dUKlDwl2X5wyTlHnosOvr0goTpQRpHk92IpTVoKGXRJHz3iiv5Nh4WSIZB4Ex/4nhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003809; c=relaxed/simple;
	bh=ATPz90HRMzTO45UePY5i8G0/KGUUiD+EHn3zGHoMIzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q2AWA3Sy9xPzgYHNhBaiIzpGyxZZ3Q7nlUUayePYemAn6QsSWnk43FNtn0idSqr7YtJbRCiNcsbbdY38H+JeO/6YVkGVlBcdk3QdGN9ObR0rxC7nd2ufaPhub1xG1/Gyc97yL4oX4queD6t/xWXiA8A+8ZiRZ+bjnwIDlRLq+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lv6xc298; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea0150ee46dso4079785276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758003806; x=1758608606; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzwxSCgUK/3UElXn+qMCVZOXd6lLimgLpQ+KrGfwqaU=;
        b=lv6xc298WRJweENer27hHOnZy0J1mSXlDgmMJ1XczXvig9lmT8IYSsn9wC0mwdfdj5
         e2gtCB9JxtDJOurDvlfbaUzHHwKflOORnpiA5dc+y3kvu3dZCX6i4KBcdxZ17sleigYY
         gBLX12DMTlSLsrsCCJObjFN4QNvzBCd1Yo26iwrOOeADEc9m77h2TsFWtfwIWY+BUdtD
         rM2niwRROy03NsATXmlmhT+G43nmno+aSv1AGiF9uvqWiSCfynDgsiD1YkFSoa7d2HNT
         SCfpVm1fDymRq5fAGHZUjmuj3fXsdACYAKt95DiS0JTGHYdbT0Ib95o1aC3W0qV7NcSh
         KIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758003806; x=1758608606;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzwxSCgUK/3UElXn+qMCVZOXd6lLimgLpQ+KrGfwqaU=;
        b=bvmLY+xdIJE9KU0wRco0O3pqethwcy6XANg4QKQJ+GuBS+hcuXmhcBxc9CnWywEsO2
         cCJ76Jg8gZojfetQRjiapEBVHeR8BlmxMdX4cPYlY6YLrdLBetAIM2y/TuKpMuV8KENf
         xg4b0vcLgKIgYzXGBYrW6lDjaSzc+q1qk80dOSAU1jZoe1dmyxcAlrABlc3gPP7kJho9
         wRA+8teDdWKEDRD3H6RW0eC6r8cNTqIEDChRh/5c1CyRi1WTo3ZvFINYso0cXPaUb+HL
         EdKDSyxcvLbS9Ua8YDRktAHPWWpCP2JdLLGmNnTZz43Q+4LacE4qFrCorLzsJhBfDGvl
         TfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4cHo97iRydWukSgnH/xR+y33uj/kTwn8GLiTAnumwY86wmt0hgT70Fb689UQ4mtZ3VUgydOZOIhM+bKmhBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpC8GdHKO4fEVBucSKALpQT+VKl1a1O2S1jUcKwBJHtp6Le3Y
	Wfz1+ah0FqpkiQe1AIUOYlMRqX8djVE11qTNwU+G2r5+l4f2jQt82OIpmsu+NAAeAQ==
X-Gm-Gg: ASbGnct7MlJOiHL4OFdUM3XoAJDbQQHFEngiGL0S1T4y070yqhMlbwTg7G2dQ/sxvEZ
	rXJekSnsdBGG+zg47x0thNhreSU51dS9zw1HWQa2dBJsnw96DiWhLou6k7tp6C0xHHYhXKqHJbW
	PkhwBiwJOGsSvwbWi7ABjIXBPuXECs0MpmPJOjzTGv7DJTNdBPpYQwdANp7fxaVQ9EFUWwGIghg
	obgwh/JNKd9tISapFxbYbQ5R/vwXeAidwqT0Yl8Z4A/cxXgnkPjspvXyliEZ0uJiswjkVHQwyX5
	KnC7d6Bs1e5FVouESVM0ymmno9jTqeNVlafYmRe3KGu/WGgLzq3PCKjf/EPopeJhZykIxRFlkTt
	N1cMDD8TIFnC8qjnk9kLUio0JeFx41sQcfd70FDHhJhV0YGexQ/4fKNDXTPjxuM/dNVFRDAY0cv
	TcITFOFKwMlfgDGQ==
X-Google-Smtp-Source: AGHT+IFYH7nKR98YSl0bgd4j6elLmVBr5qc5bTleI6LMDXL64/KgQAEWWcRI4ClTxXA+31LnE3T7pA==
X-Received: by 2002:a05:690c:b13:b0:71f:eb2b:83e0 with SMTP id 00721157ae682-73062ca43c8mr138095197b3.13.1758003805348;
        Mon, 15 Sep 2025 23:23:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7683148dsm38488107b3.23.2025.09.15.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:23:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 23:23:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Roy, Patrick" <roypat@amazon.co.uk>
cc: "Thomson, Jack" <jackabt@amazon.co.uk>, 
    "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
    "Cali, Marco" <xmarcalx@amazon.co.uk>, 
    "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, 
    Elliot Berman <quic_eberman@quicinc.com>, 
    "willy@infradead.org" <willy@infradead.org>, 
    "corbet@lwn.net" <corbet@lwn.net>, 
    "pbonzini@redhat.com" <pbonzini@redhat.com>, 
    "maz@kernel.org" <maz@kernel.org>, 
    "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
    "joey.gouly@arm.com" <joey.gouly@arm.com>, 
    "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
    "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
    "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
    "will@kernel.org" <will@kernel.org>, 
    "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
    "kernel@xen0n.name" <kernel@xen0n.name>, 
    "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
    "palmer@dabbelt.com" <palmer@dabbelt.com>, 
    "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
    "alex@ghiti.fr" <alex@ghiti.fr>, 
    "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
    "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
    "hca@linux.ibm.com" <hca@linux.ibm.com>, 
    "gor@linux.ibm.com" <gor@linux.ibm.com>, 
    "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
    "svens@linux.ibm.com" <svens@linux.ibm.com>, 
    "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
    "luto@kernel.org" <luto@kernel.org>, 
    "peterz@infradead.org" <peterz@infradead.org>, 
    "tglx@linutronix.de" <tglx@linutronix.de>, 
    "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
    "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
    "trondmy@kernel.org" <trondmy@kernel.org>, 
    "anna@kernel.org" <anna@kernel.org>, 
    "hubcap@omnibond.com" <hubcap@omnibond.com>, 
    "martin@omnibond.com" <martin@omnibond.com>, 
    "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
    "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
    "david@redhat.com" <david@redhat.com>, 
    "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
    "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
    "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, 
    "surenb@google.com" <surenb@google.com>, 
    "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>, 
    "daniel@iogearbox.net" <daniel@iogearbox.net>, 
    "andrii@kernel.org" <andrii@kernel.org>, 
    "martin.lau@linux.dev" <martin.lau@linux.dev>, 
    "eddyz87@gmail.com" <eddyz87@gmail.com>, 
    "song@kernel.org" <song@kernel.org>, 
    "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
    "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
    "kpsingh@kernel.org" <kpsingh@kernel.org>, 
    "sdf@fomichev.me" <sdf@fomichev.me>, 
    "haoluo@google.com" <haoluo@google.com>, 
    "jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
    "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
    "peterx@redhat.com" <peterx@redhat.com>, 
    "jannh@google.com" <jannh@google.com>, 
    "pfalcato@suse.de" <pfalcato@suse.de>, 
    "axelrasmussen@google.com" <axelrasmussen@google.com>, 
    "yuanchu@google.com" <yuanchu@google.com>, 
    "weixugc@google.com" <weixugc@google.com>, 
    "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
    "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
    "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
    "shuah@kernel.org" <shuah@kernel.org>, 
    "seanjc@google.com" <seanjc@google.com>, 
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
    "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
    "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
    "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
    "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
    "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
    "devel@lists.orangefs.org" <devel@lists.orangefs.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, 
    "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
In-Reply-To: <20250912091708.17502-2-roypat@amazon.co.uk>
Message-ID: <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
References: <20250912091708.17502-1-roypat@amazon.co.uk> <20250912091708.17502-2-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Sep 2025, Roy, Patrick wrote:

> From: Elliot Berman <quic_eberman@quicinc.com>
> 
> When guest_memfd removes memory from the host kernel's direct map,
> direct map entries must be restored before the memory is freed again. To
> do so, ->free_folio() needs to know whether a gmem folio was direct map
> removed in the first place though. While possible to keep track of this
> information on each individual folio (e.g. via page flags), direct map
> removal is an all-or-nothing property of the entire guest_memfd, so it
> is less error prone to just check the flag stored in the gmem inode's
> private data.  However, by the time ->free_folio() is called,
> folio->mapping might be cleared. To still allow access to the address
> space from which the folio was just removed, pass it in as an additional
> argument to ->free_folio, as the mapping is well-known to all callers.
> 
> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> [patrick: rewrite shortlog for new usecase]
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>  Documentation/filesystems/locking.rst |  2 +-
>  fs/nfs/dir.c                          | 11 ++++++-----
>  fs/orangefs/inode.c                   |  3 ++-
>  include/linux/fs.h                    |  2 +-
>  mm/filemap.c                          |  9 +++++----
>  mm/secretmem.c                        |  3 ++-
>  mm/vmscan.c                           |  4 ++--
>  virt/kvm/guest_memfd.c                |  3 ++-
>  8 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index aa287ccdac2f..74c97287ec40 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -262,7 +262,7 @@ prototypes::
>  	sector_t (*bmap)(struct address_space *, sector_t);
>  	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
>  	bool (*release_folio)(struct folio *, gfp_t);
> -	void (*free_folio)(struct folio *);
> +	void (*free_folio)(struct address_space *, struct folio *);
>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>  	int (*migrate_folio)(struct address_space *, struct folio *dst,
>  			struct folio *src, enum migrate_mode);

Beware, that is against the intent of free_folio().

Since its 2.6.37 origin in 6072d13c4293 ("Call the filesystem back
whenever a page is removed from the page cache"), freepage() or
free_folio() has intentionally NOT taken a struct address_space *mapping,
because that structure may already be freed by the time free_folio() is
called, if the last folio holding it has now been freed.

Maybe something has changed since then, or maybe it happens to be safe
just in the context in which you want to use it; but it is against the
principle of free_folio().  (Maybe an rcu_read_lock() could be added
in __remove_mapping() to make it safe nowadays? maybe not welcome.)

See Documentation/filesystems/vfs.rst:
free_folio is called once the folio is no longer visible in the
page cache in order to allow the cleanup of any private data.
Since it may be called by the memory reclaimer, it should not
assume that the original address_space mapping still exists, and
it should not block.

Hugh

