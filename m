Return-Path: <linux-kselftest+bounces-19190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95033993D0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADDC1F24732
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BF1E535;
	Tue,  8 Oct 2024 02:50:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F571DFE8
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355836; cv=none; b=nU1xef42pxza87afuucTRxgiHABzoycnCGu5K5VNENwTEE0DMm/OhLsM0sTxG+JhbXwS1i5CNXxtNnrDjzDig6Hmum+yg4SSbnidzh2pynTF2NGatWQsWgSZE0gdTeLVk3jryJEJBPt9gdMRWW8KeyYTpRaUsKA4IuOzrSAPhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355836; c=relaxed/simple;
	bh=uqGj5duSkjzf8vWtNUph0jyV7tylvNj9TcFFAh7fGdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOwRN8KJuCnBp/58m+22UxPHH6MK2NOY7yN8Mxyx735/ClQCAN8XHZ9d8EOq0b0bK8ZFeR47ITiZJQ4btBwDUSPxkaIbscRV4mc7/0VE2U5N2zLISbSjqv0OzAqjZz5eaz5WeX0/UyiaN7txvoaNGfzrg5BJh8/WPG4BuotupSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XN0pt744qz2DdC6;
	Tue,  8 Oct 2024 10:49:26 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BE5D1A0170;
	Tue,  8 Oct 2024 10:50:30 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:50:30 +0800
Message-ID: <8c3aa46a-9955-eb46-95de-46c72b4ee3c4@huawei.com>
Date: Tue, 8 Oct 2024 10:50:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
To: Shuah Khan <skhan@linuxfoundation.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
CC: <shuah@kernel.org>, <liwei391@huawei.com>, <broonie@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
 <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
 <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
 <87684869-4565-4a4a-845f-4301242be52a@linuxfoundation.org>
 <702f6d09-5216-eef5-299d-6445cfca8233@huawei.com>
 <c491b362-5ba1-462b-a033-8a5de45c406a@linuxfoundation.org>
Content-Language: en-US
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <c491b362-5ba1-462b-a033-8a5de45c406a@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)

On 2024/10/4 6:21, Shuah Khan wrote:
> Please send me v2 with sched.h included explicitly. It is better do do so
> than having it come from <phread.h> indirectly.
> 

Sorry for the late response, I have sent the v2 patch.

https://lore.kernel.org/all/20241008023332.19902-1-liaoyu15@huawei.com/

Best regards,
Yu

