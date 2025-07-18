Return-Path: <linux-kselftest+bounces-37543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099FB09B6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 08:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB5A5858F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 06:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610DF211A35;
	Fri, 18 Jul 2025 06:28:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFC153BD9
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820088; cv=none; b=iPAONcq2Xu+A4I2b3s4QTYxPFx2U60hT7lUfWHZU3FmOn4Wqgf+7k0btW2nTtvZuPh7gWF6+ABzx5ZQKpbcbjRnwXcjBKhU4c2bBRa27HyK2olP6xpkACNnkvi9vBXUqRtfthEAWERWk2Qx6+qjUZkGLxrVVjOBtDs7+792mRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820088; c=relaxed/simple;
	bh=sd8Ij5g8+ZRuI71bObPWyKWOa48/VmLz/gTmRodz6z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGunNGa0Q8HjCvgS4e6I8RDfNAKilxufsmX4G1gdnBva2Rh7QSwLSBqtmClAyG3xqSrQJqOtf6dyAp1fh0TLXvJSb6ztAwj4kYDJyl65YjyHj0i+ROLzZuJt5tpK3H/WEpscSveW6g7n6F055krDWEajcNCg6WWk4cM1/Ot4FqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 553cefd863a011f0b29709d653e92f7d-20250718
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0555c4eb-0c45-4a6e-9089-85163eb6ee26,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:0555c4eb-0c45-4a6e-9089-85163eb6ee26,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:46f8f2ff3d95a167e0444120511bf509,BulkI
	D:250717215444LBUIQCD2,BulkQuantity:2,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 553cefd863a011f0b29709d653e92f7d-20250718
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 408332628; Fri, 18 Jul 2025 14:27:52 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,  shuah@kernel.org,
  damon@lists.linux.dev,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  enze.li@gmx.com
Subject: Re: [PATCH] selftests/damon: introduce _common.sh to host shared
 function
In-Reply-To: <20250717161454.62245-1-sj@kernel.org> (SeongJae Park's message
	of "Thu, 17 Jul 2025 09:14:54 -0700")
References: <20250717161454.62245-1-sj@kernel.org>
Date: Fri, 18 Jul 2025 14:27:48 +0800
Message-ID: <87jz46rp23.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi SJ, Joshua,

On Thu, Jul 17 2025 at 09:14:54 AM -0700, SeongJae Park wrote:

> Hi Joshua,
>
> On Thu, 17 Jul 2025 06:54:32 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
>
>> On Thu, 17 Jul 2025 17:19:02 +0800 Enze Li <lienze@kylinos.cn> wrote:
>> 
>> Hi Enze,
>> 
>> Thank you for the patch! I just have a few comments about the patch.
>> 
>> > The current test scripts contain duplicated root permission checks
>> > in multiple locations.  This patch consolidates these checks into
>> > _common.sh to eliminate code redundancy.
>> 
>> Is there a reason we named the file _common.sh? IIRC there are no other files
>> that begin with an underscore, so it might be confusing for users. Maybe
>> remaining it to damon_common.sh might fit better with the convention used
>> by other selftests. 
>
> This is my personal pattern that I sometimes use, to distinguish files that
> aimed to be only indirectly be used.  We already have a file of the pattern,
> namely _damon_sysfs.py.
>
> I don't think this pattern is particularly good, but not making something
> worse, so I'm ok with current file name.

Yes, I've noted the naming convention from _damon_sysfs.py and have
maintained consistency with the existing pattern in this patch. :)

>
>> 
>> [...snip...]
>> 
>> > diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
>> > new file mode 100644
>> > index 000000000000..3920b619c30f
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/damon/_common.sh
>> > @@ -0,0 +1,14 @@
>> > +#!/bin/bash
>> > +# SPDX-License-Identifier: GPL-2.0
>> > +
>> > +# Kselftest frmework requirement - SKIP code is 4.
>> > +ksft_skip=4
>> > +
>> > +check_dependencies()
>> > +{
>> > +	if [ $EUID -ne 0 ]
>> > +	then
>> > +		echo "Run as root"
>> > +		exit $ksft_skip
>> > +	fi
>> > +}
>> > diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
>> > index 61b80197c896..0d128d809fd3 100755
>> > --- a/tools/testing/selftests/damon/lru_sort.sh
>> > +++ b/tools/testing/selftests/damon/lru_sort.sh
>> > @@ -1,14 +1,9 @@
>> >  #!/bin/bash
>> >  # SPDX-License-Identifier: GPL-2.0
>> >  
>> > -# Kselftest framework requirement - SKIP code is 4.
>> > -ksft_skip=4
>> 
>> Hm, I think factoring out check_dependencies() is a good idea, but maybe we
>> should keep ksft_skip in here since other checks in the script use the value?
>> My 2c is that it might make it unnecessarily opaque for others.
>> Same comment applies for the other files as well. 
>> 
>> But I will let SJ comment on this more ;)
>
> I agree Joshua's point.  I'd prefer keeping ksft_skip definition here.
>

Thank you for the review.  I'll send v2 addressing your comments to the
list soon.

BR,
Enze

>> 
>> Thank you for your patch, I hope you have a great day!
>
> Thank you for your valuable comments, Joshua :)
>
>
> Thanks,
> SJ
>
> [...]

