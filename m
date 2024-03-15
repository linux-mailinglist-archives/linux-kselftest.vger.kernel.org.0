Return-Path: <linux-kselftest+bounces-6363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D087D0C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7381F238CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0B45025;
	Fri, 15 Mar 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZLCF+Nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E6405F8;
	Fri, 15 Mar 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518149; cv=none; b=ewtP0rBIQOal2t6ek1HkMXhNWvHJOa1wLhZkqojyPi42wsDt1UjvqZnQ4qVKTvJpkwWcEZH0h/a8jB6Kg1C2v2F1YETGIqzknA/iJUj51gohoQW4dpkDjB3zYvmIIqJBlwKMK2dS7OrgyNVRk1ZuW0Ch8oB+auDHw1Z3wgzyaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518149; c=relaxed/simple;
	bh=vRw+Fx0QN/gfXAkPDxRAnnva2M52l29vBj6puMeNuS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9LERzlEzK0D/TKG4bosjU+4U/GjDg3+83CX1C6ERqdZxFv4w8qT0LI2d67uWH2GY/XUSUBoHPwpHIcDfqRFgkgI6MT2fI/CAiA4sHMlqAX46sKohBK93pD5RKyvNteUzpyk9UCkJ7QgjDXtvtpMq9ZFYY5isNUkq1WYxgte6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZLCF+Nr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=L5ZB8foePTnF4u2I0lA9UIhadnuaVZ3VBbYBwPMYSG4=; b=cZLCF+NrU87YVXFLSgGkTXf42T
	CKeJp4b1SUSmKUE/gYhLRXujT7PEUZrO+FDWGsSzMgu5rQzbARF1z0JNSWuqIB1r4YsxouSFk7PVv
	UDr3T4kmzE9Ru6KkwCgiPAIbMRMqzKkU7JtlPIx+1W13TKboDTGrZnlJZmcFk4tF/y5Kt5pFYTLIC
	gmfx0oJ2XT3W2FYJ7fb3kfpodUTdPtXXF4pnX0IF37KKpdbiCrcLX1sgebgHNJPrxwvx2VK+MizqD
	jz93GA2ZZGOndq0TEQ/eQH0jslBPsly8vonut6UrPHaacFEMkajC4QQwnHTj8Z0IvnJPwQeZDDTsA
	AKBLZhkA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl9uM-00000000jiF-454t;
	Fri, 15 Mar 2024 15:55:47 +0000
Message-ID: <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
Date: Fri, 15 Mar 2024 08:55:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] HID: bpf: export hid_hw_output_report as a BPF
 kfunc
Content-Language: en-US
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
 <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/24 07:44, Benjamin Tissoires wrote:
> +/**
> + * hid_bpf_hw_output_report - Send an output report to a HID device
> + *
> + * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_context()
> + * @buf: a %PTR_TO_MEM buffer
> + * @buf__sz: the size of the data to transfer
> + *
> + * @returns the number of bytes transferred on success, a negative error code otherwise.
> + */

Minimum change:

      @returns:

Preferred change:

      Returns:

"@returns" is not documented.


Thanks.
-- 
#Randy

