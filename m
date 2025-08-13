Return-Path: <linux-kselftest+bounces-38816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E0B23EB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 05:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCA7682530
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8729BD9A;
	Wed, 13 Aug 2025 03:04:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDE299A8E;
	Wed, 13 Aug 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054286; cv=none; b=W22Yohzlkt83s3vWsa3ItAfF/ShPdHPZ5ShP9+b65j8hyCJwimgMgRPSZ/pqUOCBzS7AKxpjNSxEa2BC35JwNaFIZv41neXKU1jDyZlbcvPZXVSbFt+D6hK0e3GFTjYU1WNKMfXgo4s1un2M2cmriGUnS/MNUxq0mADy0B1a4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054286; c=relaxed/simple;
	bh=ja1ztIR1AE+ObunlAW/yVyeiKfecAzX/FytL5Q5r05c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nvX+c26y0XVdKT14NHv0C7SFvx4Xa+eccMvgDMIHT21kN90g02iX4R/seAtMFO6t6jd7Ee3sB9m/DEqyL6hJ7tpR0pfS3hA6tdFl9D1DDXOBJgyKCqOrU1lmXWje+KLyuHWSusr+VmMRAmj7Vw1Tk5dIpDRjX0nFr2U2gnXs5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f547fcc77f211f0b29709d653e92f7d-20250813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:61a2bf84-6726-42ca-bdc4-8c887ae87ba7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:61a2bf84-6726-42ca-bdc4-8c887ae87ba7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:354314cd71732fa740b5e7583b0f8b67,BulkI
	D:250813110438OSDH4HH7,BulkQuantity:0,Recheck:0,SF:17|19|24|45|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3f547fcc77f211f0b29709d653e92f7d-20250813
X-User: lienze@kylinos.cn
Received: from kylin [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1277418137; Wed, 13 Aug 2025 11:04:37 +0800
From: Enze Li <lienze@kylinos.cn>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,  SeongJae Park
 <sj@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  damon@lists.linux.dev,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: q[PATCH] selftests/damon: fix damon selftests by installing
 _common.sh
In-Reply-To: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
	(Sang-Heon Jeon's message of "Tue, 12 Aug 2025 22:27:00 +0900")
References: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
	<CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
	<CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
Date: Wed, 13 Aug 2025 11:04:33 +0800
Message-ID: <87v7mrvs5a.fsf_-_@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Alexandre, Sang-Heon

On Tue, Aug 12 2025 at 10:27:00 PM +0900, Sang-Heon Jeon wrote:

> Hello, Alexandre
>
> On Tue, Aug 12, 2025 at 9:32=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail=
.com> wrote:
>>
>> Hello, Alexandre
>>
>> On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
>> >
>> > _common.sh was recently introduced but is not installed and then
>> > triggers an error when trying to run the damon selftests:
>> >
>> > selftests: damon: sysfs.sh
>> > ./sysfs.sh: line 4: _common.sh: No such file or directory
>> >
>> > Install this file to avoid this error.

Excellent catch!  This patch unlocks a testing method that was
completely off my radar. :)

>>
>> I tried to reproduce those error with my vm environment but I failed;
>> with my workaround test method, it doesn't exist.
>> If you're okay, could you please tell me line by line how you execute
>> tests in what environment?
>> I'm also struggling with the test environment, as well.
>
> I succeeded to reproduce and also check that this patch removes those err=
ors.
>

Thanks to Sang-Heon for helping reproduce this issue.  I reproduce this
issue locally as well and I can confirm that this patch will fix it
successfully.

Here's my reproduction procedure:

  # cd /root/linux/
  # make -C tools/testing/selftests/ install INSTALL_PATH=3D/root/test-dir/
  # cd /root/test-dir/
  # ./run_kselftest.sh -c damon

and I got the following error,

  TAP version 13
  1..13
  # timeout set to 45
  # selftests: damon: sysfs.sh
  # ./sysfs.sh: line 4: _common.sh: No such file or directory
  # ./sysfs.sh: line 369: check_dependencies: command not found=20=20=20=20=
=20
  ok 1 selftests: damon: sysfs.sh

with Alexandre's patch applied, I got this,

  TAP version 13=20=20
  1..13
  # timeout set to 45
  # selftests: damon: sysfs.sh
  ok 1 selftests: damon: sysfs.sh

The root cause was my misunderstanding of the TEST_FILES macro.  I've now
refined the testing methodology - thanks all for the guidance.

Tested-by: Enze Li <lienze@kylinos.cn>

Best Regards,
Enze

>> > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host sh=
ared function")
>> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > ---
>
> Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>
>
>> >  tools/testing/selftests/damon/Makefile | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/se=
lftests/damon/Makefile
>> > index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a=
08f2ad008e6b28ac87 100644
>> > --- a/tools/testing/selftests/damon/Makefile
>> > +++ b/tools/testing/selftests/damon/Makefile
>> > @@ -4,6 +4,7 @@
>> >  TEST_GEN_FILES +=3D access_memory access_memory_even
>> >
>> >  TEST_FILES =3D _damon_sysfs.py
>> > +TEST_FILES +=3D _common.sh
>> >
>> >  # functionality tests
>> >  TEST_PROGS +=3D sysfs.sh
>> >
>> > ---
>> > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
>>
>> Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
>> the same base-commit environment.
>
> However, I'm still not sure that this patch is in the correct
> baseline. maybe it will not cause any problems with the merge
> though... but I'm not sure. So I didn't add a reviewed-by tag.
>
>> > change-id: 20250812-alex-fixes_manual-aed3ef75dd83
>> >
>> > Best regards,
>> > --
>> > Alexandre Ghiti <alexghiti@rivosinc.com>
>> >
>> >
>>
>> Thank you for great work!
>>
>> Best Regards.
>> Sang-Heon Jeon
>
> Best Regards.
> Sang-Heon Jeon

