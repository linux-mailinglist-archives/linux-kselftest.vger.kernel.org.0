Return-Path: <linux-kselftest+bounces-6362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30A87D0BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08052828C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0A3FB26;
	Fri, 15 Mar 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDHTsKZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EA3D963;
	Fri, 15 Mar 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518146; cv=none; b=SEwWztWrNx/P2Y04srixVm4wa051GaLiaVWAhJmYSNmAiWFKDD51penysgBFXh+Y9aYmtnzKxM33BKZQY7FXxqHY/JhVmtjPdih5aM0M5O8n9oEHTJ736Ho9BBwjf3i8oeC5kZHse6974+4OwOY9ZZsBggSxv9BXX2IpncK7PgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518146; c=relaxed/simple;
	bh=6ip9Uj32dWRB+V8eh6SOYguo6Df3SxdRX95ROSWdS4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQg9/lTC/yykVZLerShDi/WtzznzjwflosZkBHaDNRhgKchV494XkpikBL2fBekhHyWigRURgEe2dQPomYgi9eTBaPNGsXrL+VE5Evhv/lLyvzU6EmlHVcifLaqZ92PxlCsyJcmWmU6XPuhoHaOhQbOHoPtpAhdHDP39F7TLG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qDHTsKZe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZVnxJ9g62UEeeePtv4TFZg6ReNxfPFWR59o9aOsZ7X0=; b=qDHTsKZeQqNiiNS+RC206jLqGQ
	HQEHYVnr9xz2S/5szXSF9n1CpAWNN8q/iN1TeevdT47fI633bcvyd2RDNNSaOHa7SkCaHCcJKNKmk
	ReyPdTEVYrGCB+Od93cmM+548OAAHUt+RMy3nvVVS9iMcvdNQedk9YU0mXjtqf5YEK2yfz3kRicU7
	YoxjoCpJbt0g8gunrCWomp7y5NcSiitgRJBIxSN5FC6H9ItmgQIGHUUq2AjA+qiZzJZAIzwPAYcJB
	zRwVVgnQQD+XL05J8FHEfx27exG5HburFXdFHh19kyKvGurVQKvfokHrw6rWVSj7Fo0bfesd49uF5
	1jEYkcKQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl9uI-00000000jiF-2tEl;
	Fri, 15 Mar 2024 15:55:42 +0000
Message-ID: <b49e2350-610a-4841-921d-3bdbf6defea4@infradead.org>
Date: Fri, 15 Mar 2024 08:55:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] HID: bpf: allow to inject HID event from BPF
Content-Language: en-US
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
 <20240315-b4-hid-bpf-new-funcs-v4-5-079c282469d3@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-5-079c282469d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/24 07:44, Benjamin Tissoires wrote:
> It can be interesting to inject events from BPF as if the event were
> to come from the device.
> For example, some multitouch devices do not all the time send a proximity
> out event, and we might want to send it for the physical device.
> 
> Compared to uhid, we can now inject events on any physical device, not
> just uhid virtual ones.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> no changes in v4
> 
> no changes in v3
> 
> no changes in v2
> ---
>  Documentation/hid/hid-bpf.rst      |  2 +-
>  drivers/hid/bpf/hid_bpf_dispatch.c | 29 +++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c             |  1 +
>  include/linux/hid_bpf.h            |  2 ++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
> index a575004d9025..0765b3298ecf 100644
> --- a/Documentation/hid/hid-bpf.rst
> +++ b/Documentation/hid/hid-bpf.rst
> @@ -179,7 +179,7 @@ Available API that can be used in syscall HID-BPF programs:
>  -----------------------------------------------------------
>  
>  .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
> -   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_allocate_context hid_bpf_release_context
> +   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
>  
>  General overview of a HID-BPF program
>  =====================================
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index a5b88b491b80..e1a650f4a626 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -508,6 +508,34 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
>  	kfree(dma_data);
>  	return ret;
>  }
> +
> +/**
> + * hid_bpf_input_report - Inject a HID report in the kernel from a HID device
> + *
> + * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_context()
> + * @type: the type of the report (%HID_INPUT_REPORT, %HID_FEATURE_REPORT, %HID_OUTPUT_REPORT)
> + * @buf: a %PTR_TO_MEM buffer
> + * @buf__sz: the size of the data to transfer
> + *
> + * @returns %0 on success, a negative error code otherwise.

Minimum change:

      @returns:

Preferred change:

      Returns:

"@returns" is not documented.

> + */
> +__bpf_kfunc int
> +hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
> +		     const size_t buf__sz)
> +{


-- 
#Randy

