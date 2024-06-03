Return-Path: <linux-kselftest+bounces-11095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD88D7A62
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 05:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF181F2143C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A2CA7D;
	Mon,  3 Jun 2024 03:13:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51055EAC8;
	Mon,  3 Jun 2024 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717384415; cv=none; b=E8TVgzZEiZofXSdCLYhO3oU7G6C4VtvBtdVxz5j5hD1feG68PpZiIdes4KN0cKsUro/n8No1HAbiefkZrR5t7OBKjbiFMB4Lgv6SNS3dW855vodfacvOwIRO+4CUshSf5t+3b0GAYsWTBVQ0C5f0b8SZZvvfxUXBhbvcuCwGVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717384415; c=relaxed/simple;
	bh=lVK/d+uRECMZUdrigzltKVtztoF/OvTfyfLRUldYz1g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZIg64Y8BBJQAE/wqtyiBuXymCldCKRfTe+R8bdtStd9JdAsb6LKzLjOKcsESp5U9PjCy5u57VQB2KgcSsqBzaIce/UbfaqysL9Czf6SYk9ftq3MwK+6OBnsuU4ccWC62Xe3WcZeff2ZlVGFs4rXVpGf/yJRhugbgB7GTJr3f80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VszHQ4m18z1yslg;
	Mon,  3 Jun 2024 11:10:10 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8C21A0188;
	Mon,  3 Jun 2024 11:13:25 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 11:13:24 +0800
Subject: Re: [PATCH] KVM: selftests: remove unused struct
 'memslot_antagonist_args'
To: <linux@treblig.org>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240602235529.228204-1-linux@treblig.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f9e022a6-31ba-72e6-2941-4b3a17906fa5@huawei.com>
Date: Mon, 3 Jun 2024 11:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240602235529.228204-1-linux@treblig.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/6/3 7:55, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'memslot_antagonist_args' is unused since the original
> commit f73a3446252e ("KVM: selftests: Add memslot modification stress
> test").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Looks good,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

