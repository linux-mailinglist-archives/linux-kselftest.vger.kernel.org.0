Return-Path: <linux-kselftest+bounces-18714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E198B25D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 04:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9511C21942
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0346BFD4;
	Tue,  1 Oct 2024 02:44:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CB41AAC;
	Tue,  1 Oct 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750664; cv=none; b=Mr/D7vsl1O/iHeJww7MpszSzpUk8iJhDD64hxG9rFt8LTtl4BnXpvrGmQdklE51zfdJJJjNA/VQOY0hYpxOyuLs5U/U1IbsOcNuuiRUtRyDWMVBwLwaU6ieBdSKJbwq0Fv+tveXpNruQ0hb1VmFO3Rfpo9cIERNaAZItTlkSK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750664; c=relaxed/simple;
	bh=TF+L+ua5peTDuUulIo91+hCN4fiJSbOlswcrdqGyEPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIw5RGR7IGbxcCjBxQ42Fhjc6ZMrzMBjJuwTA2iw5cdFqb2WpCChvoCky3oNUiaKKBNUnHnF+ZPzCUXxZmv+eqlgG/VN8Ir7XPqO3IRbzFhMKhZhYGoC0NlXCNe5bOeKvZni8PP9UH9x3ulsG70a/Lf054rPGR+n/2pSUnAOMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 081c8da27f9f11efa216b1d71e6e1362-20241001
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:04829ff3-71a5-42a1-98ec-e2b07ae4b54c,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:82c5f88,CLOUDID:826f6a14f2f1a9ec000a2a1052ed96e0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 081c8da27f9f11efa216b1d71e6e1362-20241001
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 786073603; Tue, 01 Oct 2024 10:44:08 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 44BE7B80758A;
	Tue,  1 Oct 2024 10:44:08 +0800 (CST)
X-ns-mid: postfix-66FB61F7-7869062
Received: from [10.42.20.151] (unknown [10.42.20.151])
	by node2.com.cn (NSMail) with ESMTPA id 65302B80758A;
	Tue,  1 Oct 2024 02:44:06 +0000 (UTC)
Message-ID: <c9763b7c-fc93-44cf-bccb-9709a542e3e6@kylinos.cn>
Date: Tue, 1 Oct 2024 10:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
To: Shuah Khan <skhan@linuxfoundation.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240929085549.3528293-1-luyun@kylinos.cn>
 <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
 <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
Content-Language: en-US
From: luyun <luyun@kylinos.cn>
In-Reply-To: <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/10/1 04:57, Shuah Khan =E5=86=99=E9=81=93:
> On 9/30/24 02:38, Benjamin Tissoires wrote:
>> On Sep 29 2024, Yun Lu wrote:
>>> The HID test cases actually run tests using the run-hid-tools-tests.s=
h
>>> script. However, if installed with "make install", the=20
>>> run-hid-tools-tests.sh
>>> script will not be copied over, resulting in the following error=20
>>> message.
>>>
>>> =C2=A0=C2=A0 make -C tools/testing/selftests/ TARGETS=3Dhid install \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INSTALL_PATH=3D$KSFT=
_INSTALL_PATH
>>>
>>> =C2=A0=C2=A0 cd $KSFT_INSTALL_PATH
>>> =C2=A0=C2=A0 ./run_kselftest.sh -c hid
>>>
>>> selftests: hid: hid-core.sh
>>> bash: ./run-hid-tools-tests.sh: No such file or directory
>>>
>>> So add the run-hid-tools-tests.sh script to the TEST_FILES in the=20
>>> Makefile.
>>>
>>
>> I assume we probably also want:
>>
>> Cc: stable@vger.kernel.org
>>
>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> Not sure about the timing regarding our next PR to Linus, so in any=20
>> cases:
>>
>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
>
> Thank you. This commit appears to be right one for Fixes tag?
>
> Is this the right commit for Fixes tag:
>
> Fixes: commit ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core=20
> tests")

Yes,=C2=A0 the run-hid-tools-tests.sh script has been introduced since co=
mmit=20
ffb85d5c9e80,

but not added to TEST_FILES.

>
> Will apply with this tag added to linux-kselftest fixes for next rc
> once I get conformation.

So should I need to send a v2 patch to add the Fixes and Cc tags?


Thanks and best regards.

--Yun Lu

>
> thanks,
> -- Shuah

