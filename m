Return-Path: <linux-kselftest+bounces-19320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C981996009
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 08:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96DEB243E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDE175D4F;
	Wed,  9 Oct 2024 06:45:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066B160884;
	Wed,  9 Oct 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456353; cv=none; b=u64AFqRwWf/DRhn0+/hX1Px7SSlyvGr6ZQwPFhTGdnuhKzBg3ilWXf1o+zxwyPRQusoYXez2QxF5aq2n05Cg+vdL86hO7RTiKenioneKuImcCifK5vUuYv4FrD9vAUeeH4XKS1aDEH/t60Hf3KbrUUXTmQ+5KK7+5cdtMLlohSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456353; c=relaxed/simple;
	bh=y3R/OdfVQw//Toxh5Ba7jVhLdI/mruOtrfsaMXw1ZIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/lrhwiSTrTxngjgtTiGoPuCBRSvTG2BHBaLDG/E3ZApomt2w9Peww3QSPtNDLjaWJD/1gIucus6+f+w/YeokFBp46nLHVMkKI2WfQ2XysmIk0yjtKFggRs1qLTxLM1QUGcOhB/UW+ABEbkVODWXsau+CLF1OJYPkHgZGRnfN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a110008860a11efa216b1d71e6e1362-20241009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2320cfc8-3a9d-4ff3-8c70-5c26baf5c2c7,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:82c5f88,CLOUDID:9a1f0c2a7dbc2fad7d675b4dfba75ee9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1a110008860a11efa216b1d71e6e1362-20241009
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 536540262; Wed, 09 Oct 2024 14:45:41 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 824D3B8075B2;
	Wed,  9 Oct 2024 14:45:41 +0800 (CST)
X-ns-mid: postfix-67062695-44634086
Received: from [10.42.20.151] (unknown [10.42.20.151])
	by node2.com.cn (NSMail) with ESMTPA id E03AEB8075B2;
	Wed,  9 Oct 2024 06:45:40 +0000 (UTC)
Message-ID: <292ce016-51a9-4e0f-a7e2-f72d025bdb82@kylinos.cn>
Date: Wed, 9 Oct 2024 14:45:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add the missing tests directory
To: Shuah Khan <skhan@linuxfoundation.org>, jikos@kernel.org,
 bentiss@kernel.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008093120.3081899-1-luyun@kylinos.cn>
 <e54c70db-a14d-43e6-b221-0c0712893ee7@linuxfoundation.org>
Content-Language: en-US
From: luyun <luyun@kylinos.cn>
In-Reply-To: <e54c70db-a14d-43e6-b221-0c0712893ee7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/10/9 03:33, Shuah Khan =E5=86=99=E9=81=93:
> On 10/8/24 03:31, Yun Lu wrote:
>> Commit 160c826b4dd0 ("selftest: hid: add missing=20
>> run-hid-tools-tests.sh")
>> has added the run-hid-tools-tests.sh script for it to be installed, bu=
t
>> I forgot to add the tests directory together.
>>
>> In fact, the run-hid-tools-tests.sh script uses the scripts in the tes=
ts
>> directory to run tests. The tests directory also needs to be added to =
be
>> installed
> Include the error you are seeing in here.

If running the test case without the tests directory,=C2=A0 the error mes=
sage=20
will like this:

 =C2=A0=C2=A0=C2=A0 cd $KSFT_INSTALL_PATH

 =C2=A0=C2=A0=C2=A0 ./run_kselftest.sh -t hid:hid-core.sh


# /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331:=20
PluggyTeardownRaisedWarning: A plugin raised an exception during an=20
old-style hookwrapper teardown.
# Plugin: helpconfig, Hook: pytest_cmdline_parse
# UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [.=
..]
# __main__.py: error: unrecognized arguments: --udevd
#=C2=A0=C2=A0 inifile: None
#=C2=A0=C2=A0 rootdir: /root/linux/kselftest_install/hid


>
>>
>> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests"=
)
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
>> =C2=A0 tools/testing/selftests/hid/Makefile | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/hid/Makefile=20
>> b/tools/testing/selftests/hid/Makefile
>> index 38ae31bb07b5..662209f5fabc 100644
>> --- a/tools/testing/selftests/hid/Makefile
>> +++ b/tools/testing/selftests/hid/Makefile
>> @@ -18,6 +18,7 @@ TEST_PROGS +=3D hid-usb_crash.sh
>> =C2=A0 TEST_PROGS +=3D hid-wacom.sh
>> =C2=A0 =C2=A0 TEST_FILES :=3D run-hid-tools-tests.sh
>> +TEST_FILES +=3D tests
>
> What about the files if any under the tests directory?
> The install rule would handle the case, however, did
> you verify that those are copied as well?

Yes, the install rule will copy the entire directory (including all=20
files under the directory),

and I have confirmed it.


Thanks and best regards.

--Yun Lu

>
>> =C2=A0 =C2=A0 CXX ?=3D $(CROSS_COMPILE)g++
>
> thanks,
> -- Shuah
>

