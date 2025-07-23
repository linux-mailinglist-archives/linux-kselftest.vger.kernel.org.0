Return-Path: <linux-kselftest+bounces-37887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A4B0F83E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D7A172155
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45A1F541E;
	Wed, 23 Jul 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dz9TIFLN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E225D8F0
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288661; cv=none; b=GB1JP7uGv4Op7yZYv/NoBF4UpFnQzbDyAUtgpjTlXLddn05Tali9DIISwcgPRwxxwf6gX0tFVNNMEGacCqL7yvhNvMliYfNTbXlLheQ+5nzmtc2TpKn+lnsNdZ8AV2chtYBo1Xyked+GVF/OPBjIH+bYUsBQN0IBfzYYvm+wXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288661; c=relaxed/simple;
	bh=Qqa7WHVPTXx3eZOksO4x9mDerLpqCGJt8uIf4LEocVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W/I2KsjepmPAPAAReU6MfihxzlX6Fs0dudSiDX90f6o+cOt3midj2a+ZarLuiR8KljpFbsskcM10L7VL5yCtyLWli6NDcy03O4NGwe+LCi9GJpqhq5/ibRfDHCWt25Qsemw6sM/NuH7u8p9XH2YhD1EhyrxaAHU3cH7oGX6jlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dz9TIFLN; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <86524322-ebf3-41db-a1ed-9d22c67deb6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqa7WHVPTXx3eZOksO4x9mDerLpqCGJt8uIf4LEocVk=;
	b=Dz9TIFLN9NaWNFVUUg82yKzkucwVayysGvJPpd7n/fKVSZigyHfhE6mk0/2jTCFZ1gR6IP
	fUuoVLBW0VyqXEwlJ89RQG9ATZp4+jzYc4HFRPK6xlhONbX0iCJkXKte314oUchsEMaAbM
	Z2byzO9iXEbpz+SrJp55vy8TGzhgyCk=
Date: Wed, 23 Jul 2025 09:37:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Add log for attaching tracing
 programs to functions in deny list
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> Show the rejected function name when attaching tracing programs to
> functions in deny list.
>
> With this change, we know why tracing programs can't attach to functions
> like migrate_disable() from log.
>
> $ ./fentry
> libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> Attaching tracing programs to function 'migrate_disable' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


