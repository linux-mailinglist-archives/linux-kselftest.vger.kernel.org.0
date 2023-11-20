Return-Path: <linux-kselftest+bounces-326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4407F1736
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1A41C215F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832C1CF9C;
	Mon, 20 Nov 2023 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="adzt1Bor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90986A4
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 07:24:58 -0800 (PST)
Message-ID: <ce8c3296-d751-4f67-b109-a61b3d3dac89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700493896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H8FTlr9fcdwDD07hcBimFiAc3RJ94n6TR7AdGN6fa0=;
	b=adzt1BorjpRRATbF52loZ0if16onR6BG85RhCxyqcFjCvGw3pwVvW8IYSoRaeQlcRjjLdO
	wd78VcA9Hnk0Y2EvtsvezPy+o5X0SXVHJAyB0/4SlHwhcWt9JGibwaXX4nrGt1U+Mxg69x
	inGH5khwaE5jQd8ac9S8C0Ud96fgwMA=
Date: Mon, 20 Nov 2023 07:24:50 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bind_perm
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, andrii.nakryiko@gmail.com, mykolal@fb.com,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DA27C0B42E88881B6534E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563DA27C0B42E88881B6534E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/18/23 1:44 PM, Yuran Pereira wrote:
> bind_perm uses the `CHECK` calls even though the use of
> ASSERT_ series of macros is preferred in the bpf selftests.
>
> This patch replaces all `CHECK` calls for equivalent `ASSERT_`
> macro calls.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


