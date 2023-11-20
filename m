Return-Path: <linux-kselftest+bounces-328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD877F17B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86199282733
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB61DA45;
	Mon, 20 Nov 2023 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7Pyf6Rn"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 1264 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 07:44:13 PST
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E100F5
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 07:44:13 -0800 (PST)
Message-ID: <ebecf482-d785-4d8e-84a3-eb0bf901cdb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700495051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIUeiMgZscjp06DUtT53KHCOHBj10yoOgIx/xPQe91Y=;
	b=f7Pyf6RnucUbwXKoCt1CBBuZKgLm79UXGYY7eChKJcAyYkjG9UbEFbVp9CO1S7x4fusI5N
	HvqkmuuXXmakngXF91stpsTGzF1ICZu6BMLeGGVbfKAEo5FbeXMNDvzuDP8MF9zxrOfH3m
	hi9B3jpESyZ0Qr7W70pkcpvZjLdNz4M=
Date: Mon, 20 Nov 2023 07:44:05 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in vmlinux
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, andrii.nakryiko@gmail.com, mykolal@fb.com,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB656325F13ABA4DBFD4663C33E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB656325F13ABA4DBFD4663C33E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/18/23 1:47 PM, Yuran Pereira wrote:
> vmlinux.c uses the `CHECK` calls even though the use of ASSERT_ series
> of macros is preferred in the bpf selftests.
>
> This patch replaces all `CHECK` calls for equivalent `ASSERT_`
> macro calls.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


