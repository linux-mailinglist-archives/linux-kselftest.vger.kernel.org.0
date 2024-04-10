Return-Path: <linux-kselftest+bounces-7526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC189EA9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A28B22DDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BF22085;
	Wed, 10 Apr 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3uzvzJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DF20E3;
	Wed, 10 Apr 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729840; cv=none; b=bZ6halXmz88io/PzxyKTPnChS05egMrtlJVeDoFkZAZ6DtpBgd96VoCE+WqbE7/maJwFsekAQeTXr8tZWS33Lx0DX7XpWdcK939js0bE2C0ZjR/nTqqdyPKmJ61AgrCHSJy0o+nDstH0aqqwbdfGk+7pB6r/ZYq6d3sl9wwfSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729840; c=relaxed/simple;
	bh=qs6l5jxvkDTBRQoimBG8GeWEgWg+7YUN6vqxESKx63g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o2oNrlHoTGq9Fpaanx3yNXVz1sFrnMPXCSVY87M1PWK6m00TonjUo9ZbtA4dVMeO3XvX7NnnMfZmJJrHyb24w63tED7s+1tYbnULTerLRoaaCvJ8HkW2zNSLDG1nP+CpPrvJ1nUlW8cPZrk/CGIk5W2g6ybO7wbccPcHWAccMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3uzvzJA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729839; x=1744265839;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qs6l5jxvkDTBRQoimBG8GeWEgWg+7YUN6vqxESKx63g=;
  b=N3uzvzJAsxoMkZb+Cg1Bc6Gj83UuhC/pRLqV4y7nFyVYKjtHhvnvA8nJ
   O0egrWfdbGKgscHuNJhghhQKeGj1SqV1pyF/NhnaTp73h/wtFu1fmmFgl
   kF7NqM7JeB1HO19v/symA97mt1ijIUP6WIj89Px+2TQvSAU14ZO1RJnHV
   2TGjXdfM3v+jyzrT41Vqm+dBcFcG4A5tyBdWYU8wXuTL3296VRdbECJ+B
   xqLPZMSk5h4CWE+rPfPS/piM3AW4Wr4kxzMJ1CiHrloe/0iYgckIgJ86T
   BLyw3Dj+ksiYmr3LFU5s+5QK9icvNIiAkMncaoqxLnE9vSKDfe9qIGj3w
   Q==;
X-CSE-ConnectionGUID: ydyTWxHgQRadfEkjXhi33A==
X-CSE-MsgGUID: OW7cXftDRQW3cmWjVWPAPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11863830"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11863830"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:17:18 -0700
X-CSE-ConnectionGUID: cp1nF6qKSI6i7+BTGKxGuw==
X-CSE-MsgGUID: H3oek+f/TLqHQrJCTDjbhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24930831"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:17:12 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>,  Khalid Aziz <khalid.aziz@oracle.com>,
  Henry Huang <henry.hj@antgroup.com>,  Yu Zhao <yuzhao@google.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Gregory Price
 <gregory.price@memverge.com>,  Wei Xu <weixugc@google.com>,  David
 Rientjes <rientjes@google.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Muchun Song <muchun.song@linux.dev>,  Shuah
 Khan <shuah@kernel.org>,  Yosry Ahmed <yosryahmed@google.com>,  Matthew
 Wilcox <willy@infradead.org>,  Sudarshan Rajagopalan
 <quic_sudaraja@quicinc.com>,  Kairui Song <kasong@tencent.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vasily Averin <vasily.averin@linux.dev>,
  Nhat Pham <nphamcs@gmail.com>,  Miaohe Lin <linmiaohe@huawei.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Abel Wu <wuyun.abel@bytedance.com>,
  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young
 for force_scan=true
In-Reply-To: <CAJj2-QEczZzon8AhO32_B=D2MAZG+1YWp0yrgSKQOChjQnN1OA@mail.gmail.com>
	(Yuanchu Xie's message of "Tue, 9 Apr 2024 15:36:04 -0700")
References: <20240327213108.2384666-1-yuanchu@google.com>
	<20240327213108.2384666-2-yuanchu@google.com>
	<875xwr81x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAJj2-QEczZzon8AhO32_B=D2MAZG+1YWp0yrgSKQOChjQnN1OA@mail.gmail.com>
Date: Wed, 10 Apr 2024 14:15:18 +0800
Message-ID: <87plux68w9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yuanchu Xie <yuanchu@google.com> writes:

> On Mon, Apr 8, 2024 at 11:52=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Yuanchu Xie <yuanchu@google.com> writes:
>>
>> > When non-leaf pmd accessed bits are available, MGLRU page table walks
>> > can clear the accessed bit and promptly ignore the accessed bit on the
>> > pte because it's on a different node, so the walk does not update the
>> > generation of said page. When the next scan comes around on the right
>> > node, the non-leaf pmd accessed bit might remain cleared and the pte
>> > accessed bits won't be checked. While this is sufficient for
>> > reclaim-driven aging, where the goal is to select a reasonably cold
>> > page, the access can be missed when aging proactively for measuring the
>> > working set size of a node/memcg.
>> >
>> > Since force_scan disables various other optimizations, we check
>> > force_scan to ignore the non-leaf pmd accessed bit.
>> >
>> > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
>> > ---
>> >  mm/vmscan.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index 4f9c854ce6cc..1a7c7d537db6 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned =
long start, unsigned long end,
>> >
>> >               walk->mm_stats[MM_NONLEAF_TOTAL]++;
>> >
>> > -             if (should_clear_pmd_young()) {
>> > +             if (!walk->force_scan && should_clear_pmd_young()) {
>> >                       if (!pmd_young(val))
>> >                               continue;
>>
>> Sorry, I don't understand why we need this.  If !pmd_young(val), we
>> don't need to update the generation.  If pmd_young(val), the bloom
>> filter will be ignored if force_scan =3D=3D true.  Or do I miss somethin=
g?
> If !pmd_young(val), we still might need to update the generation.
>
> The get_pfn_folio function returns NULL if the folio's nid !=3D node
> under scanning,
> so the pte accessed bit does not get cleared and the generation is not up=
dated.
> Now the pmd_young flag of this pmd is cleared, and if none of the
> pte's are accessed
> before another round of scanning occurs on the folio's node, the pmd_youn=
g check
> fails and the pte accessed bit is skipped.
>
> This is fine for kswapd but can introduce inaccuracies when scanning
> proactively for
> workingset estimation.

Got it!  Thanks for detailed explanation.  Can you give more details in
patch description too?

It's unfortunate because PMD young checking helps scanning performance
much.  It's unnecessary to be done in this patchset, but I hope we can
find some way to get it back at some time.

--
Best Regards,
Huang, Ying

