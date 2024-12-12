Return-Path: <linux-kselftest+bounces-23253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0EF9EE613
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 13:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FCF286D15
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B4212FB2;
	Thu, 12 Dec 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WNRfxvdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA873212F96
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004629; cv=none; b=HI5ONAFBzKLrtH8GdeF7tOPcNslSYNevzbo0NpgOGn6b8b8vJQiyJNj1ZysdFjMGzaO8G6kpGoALlU2o4q6i3Sop1QRKZpzMNmILkFTPu2i+zzKl8egbo4kKz0JMNSnaA1mRZJdPJh0NUALNRij7RDnq0yiHZP4hWMTPGkcoHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004629; c=relaxed/simple;
	bh=4SOitpeJSxsCi3uUZNQXvqSx7dPK8Xu9nPdWBZ3pXZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxkBbZ7RYAR3oxYWg6P86W2Gl7N6UG5P34iYoG/TqzAcojcvfzazW2oYU++nGUDBXqm+UuziZDTxeIHmy1UOa5GjyKX2SK9jR7T+Jhk8fV06Pw96iF9IT97A50g/JyrFviPOgXzrebLXw2aEp6Y+SE5XQoSRy2WNiUHVhyPMMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WNRfxvdk; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734004627;
	bh=1eMLf26XKrrfXj3aFM14LgTUGaE6UhvpHVb/22mBwUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=WNRfxvdkGS3XfHsQHHV3QBZCEvGQbIOa2a+WsJ82Fgs1q1vdMYE1sED/Zr1kJady4
	 JNR2c0a9ZnlTwNIJWlbof5RrnsVqI3wjxb8yVSotRAplZYJu44r/IYdSCA6A19y3Qj
	 I0F+IRZxU/rFNOxI/hNrOhkvfXNFwUSO4W2PCdwH81yUcCkkRUPyjVtrx4l3OAmCer
	 +5VNN4Kefo8mYNpNa78jgfdB1LH4RiPuaqv0wWSeUW7MKHGFlWCaascN3rJyDWpE33
	 XiNFdYko2/5bakjuafEqHcJklwp6fAF1gavRpWZ1+5rA46E24aFA0PDT28VbuzIPi1
	 OXS/2x8JA5DHQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 0B15D34BA577;
	Thu, 12 Dec 2024 11:57:01 +0000 (UTC)
Message-ID: <d5ea10a7-7bb9-4fbe-a7b7-1871e5f697ff@icloud.com>
Date: Thu, 12 Dec 2024 19:56:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: endpoint: fix bug for 2 APIs and simplify 1
 API
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 stable@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
 <1fac71d8-dcfe-4924-ab01-dc85a822b740@stanley.mountain>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <1fac71d8-dcfe-4924-ab01-dc85a822b740@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KGwKBQwZIGmJw-R1yRjzVFkBZhgqDO3-
X-Proofpoint-GUID: KGwKBQwZIGmJw-R1yRjzVFkBZhgqDO3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_06,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=682 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120085

On 2024/12/12 17:35, Dan Carpenter wrote:
> On Tue, Dec 10, 2024 at 10:00:17PM +0800, Zijun Hu wrote:
>> This patch series is to fix bug for APIs
>> - devm_pci_epc_destroy().
>> - pci_epf_remove_vepf().
>>
>> and simplify APIs below:
>> - pci_epc_get().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
> 
> This is very good.  This is Config FS.  Is there a kself test for configfs
> or did you create your own test?
> 

no.

In order to investigate devres_release() usage for patch 1/3, i read
2 PCI source files and then find a few obvious bugs. (^^)

> regards,
> dan carpenter
> 
> 


