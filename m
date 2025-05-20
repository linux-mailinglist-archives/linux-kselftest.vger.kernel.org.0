Return-Path: <linux-kselftest+bounces-33395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C8ABD6AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3EA3A8166
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337C27466A;
	Tue, 20 May 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elDCBclS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663E270542
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740290; cv=none; b=ZZz61h3ugwwqGxROtvpGJeVDrQFFx+cYNC0fgapDu6AJQ7zoumSxZDOWu/+oWAnj+9sJUybHf8SmgEo3ukzgXQglRcEn4mKLYmxJvHNDB0XFdBrsjetYxtROtL/YDEL4xcvs5hO9oC833hbmdVLrwMQrY0EGa7mUjMJx3M9U7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740290; c=relaxed/simple;
	bh=TuAIH9bfwGkhs90AUwbat8H9o+RJq1imxYa/lL35UsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfEYYPeA0mtbdJGn1k3PJj98F0FONvJ/GzPzZjxzDyaUv7/z6JBYWvafmfGoJnqpnayC2ZimF65e2u1L4sXkYkzRLsd4cTbgth5Hucx9erefo5UmDfZqWZ39J5Q+vL5VcKdImdC0tQv44phMvMsQR3qh5jCvGwC/JMQuqGfZ3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elDCBclS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747740288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
	b=elDCBclSAR6qvQlWcRE9E1wXas1PC4ReG1izfRpYwvxA4/Iw5Mdzmqcz4ViOrPMr3PuhyB
	ZzwJEfkPDJcyAzfgolvm3ATWd+EXGG9cN02W1IKXlc69wLbXlo3HbfGFxtgiT2kfxg/msu
	yCS0jGMmUUaidY6HhlKKJufa/GD/yqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-xMVTQ0IhPfyvMA4LYfXr5A-1; Tue, 20 May 2025 07:24:46 -0400
X-MC-Unique: xMVTQ0IhPfyvMA4LYfXr5A-1
X-Mimecast-MFC-AGG-ID: xMVTQ0IhPfyvMA4LYfXr5A_1747740285
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a362939f61so1936310f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 04:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747740285; x=1748345085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
        b=xSb/F1TI6/uvUsVkxft1KOqwcS87vP92Rzq99DsZ4qmioQHQpACVKrbOJ8gQflTOSm
         6WxBZWZ8MZBdc4/uxrfV/BfyruuIHBnPCYBbfnGY96vsYY6UwDWAAg6euzRUO8tMciMD
         lfNf8MoqVG2BxBfJZdABkOVhwRH74NWaFk9gn+a5S+siXmgpCcBVR2wxks9vikRnVZKR
         G/emt1wkrEucGYm3hiGM4TUuQSOa60W55cF2xxDj02pfqykvsulE+B0YOOhFMVrtsYBl
         /Wd3sR1WFPUOkkSh66oxkTbducTs8rc9Rr51JEObfsNVg+nIFI2n7F6x12Rs2AxB05Bj
         C7rg==
X-Forwarded-Encrypted: i=1; AJvYcCX2YI8kNxz+aKjLFv0a8EIllab6TspPx5rQSu9/G6pplnQA7NrP0q+3s6ASG9kpDhpGr/jp685jMDwsVpRm6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqppT1EJsstEjkk8x4nFN4tdHM4/PtpyHW8Mv7EHmyevvdlWjG
	i/pIk1ltWYiooMPo+6+MGdWa57PvBvr2Ok2cAGrLJpkN7cmk+94ODedQrNWkFdxxb+JecqjoEJ8
	IDRaR/UrGg0uC19NfH2zc4NIBvZsPRKDL+hTqTDX/7W5JDjcVb0SuT79KddZ4Q1yEWvqTWQ==
X-Gm-Gg: ASbGncuGeiO+f4IE/wyvBfK4jgjKIVr67h5Nkz6YzLtwYkDKIaYa0/TaLrA2x1IFsLO
	pZSFBpcItNTIJ6nsLLS4cdwPqJ230KAsNVSsPzjexrhGIpGZ5HAA/nED4lTsZ4+5Ev4av4owk1y
	2wqQQhI5UKCfRhaPQSIJq/aPe8I+thdgsnQ+SHlJqCKQjDJH4sDguv9ZmsKfQ0Y1lgI7ZqCcZ3f
	gTAkhojfVs9RPnyI407YzkwkKGaN0L5P78KFubLB6/l84oWo8zXqas3ufdyzvrw69FPGcmsEjFu
	3k3whoshrkLx0N+19qk=
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718955f8f.1.1747740285496;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEofFs1HXEriOPCetmLcj952oc2+OEDOvFvT2d4euNrXMvEB2EHBEoF9oG/uDbOigZv9W8Xdg==
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718940f8f.1.1747740285150;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6254bsm16428674f8f.52.2025.05.20.04.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:24:44 -0700 (PDT)
Message-ID: <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>
Date: Tue, 20 May 2025 13:24:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 12:00 AM, Bobby Eshleman wrote:
> +tap_prefix() {
> +	sed -e "s/^/${TAP_PREFIX}/"
> +}

I think there is no need to the tap prefix to the output you intend to
'comment out', the kselftest infra should already add the tap prefix
mark to each line generated by the test,

> +
> +tap_output() {
> +	if [[ ! -z "$TAP_PREFIX" ]]; then

AFAICS TAP_PREFIX is a not empty string constant, so this function is
always a no op. If so it should be dropped.

Otherwise LGTM, thanks,

Paolo


