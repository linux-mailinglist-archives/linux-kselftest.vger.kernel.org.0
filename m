Return-Path: <linux-kselftest+bounces-29487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50910A6A395
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986101884C96
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB922422D;
	Thu, 20 Mar 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhNlYo1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3868223324
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466326; cv=none; b=OcytHBG+7oMUq/e+E03hNfBLPXVplhbCc+seFWrvn9xvlHRuJDS9mTgLHrVnJdWH1/sD4UPecng9sZcwDvHeA3UQg9HykH4MuxNpO6yUOTbcooiI5ZZ5VWqq21QRa6iIdxla7A4s6tENTgfZUVs19SssDFczi39c3fg9jjL5Gxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466326; c=relaxed/simple;
	bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtEDCpxRvDGzAuRt/IoC1A6EVidGRNUK9yi4COFm6c31rc6GWYl3ljqcNBT54H1uMQKg2afgAW00+D3IgHc45njTtR6EPtWsV/bWy66vL32lCN3WSra/y8OI9YCQ58wu7aqrz/PtvJoL4aD/e6g0Me0KoHNliLMUkLmHI/NZxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhNlYo1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742466323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
	b=FhNlYo1B/Dc+a0prExfZbE7CKjq9smiwbaICeSzanoxXBn5ZWKA9mnLlY55BVYLxIkqAHe
	ew4dEHTy7kIjVNYYW6JQXE4m8BF9mzTNyb0Qb5vjNRGfvqkQh9Y6LcDx1XNdvLm0nP9bsy
	H4sZp+czLQQlIeoDkrMvUjrM2JLWxa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-KClh8gkaPkipfXaizUeqTg-1; Thu, 20 Mar 2025 06:25:22 -0400
X-MC-Unique: KClh8gkaPkipfXaizUeqTg-1
X-Mimecast-MFC-AGG-ID: KClh8gkaPkipfXaizUeqTg_1742466321
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912b54611dso342271f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 03:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466321; x=1743071121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
        b=RwJcHo/rm8Xlw80yklOzeUDlL8GpiwnGcsTXFNMbTdfAqTQmxxamujXrULxLsSIZ/U
         n4Zz74Yi+Amr74fXbZs+Fx+SGJcwmswuzL4p0Zm4zLyfvvWR/R3Ak9IeYMaDqeuscHWt
         SO6w0A2mteOzPE/ZKAT1LH/OlSxf9kJYpZGTIV+deiW7P1JEq3sG9EuXZJfIj4fWBx+t
         arrmvq+aks9FuEAhUpxjen80wLj64uGrz7xj/16mHsrBpfNRPw4fgyx0zwUfjYoUUh0P
         oM+LtvBR507ClyHYylbpopPfCiEYli4t5sG5OatESS0xQz4FTKAklX4GJBOU5hXOf1u4
         DSEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhkBUB/N+gWUc0ORy7bPZV7uheX/ksVgERiAWc6QQnB2L7LKOo/ZpPO0ZjK4IUYKPvwi7ZEncshTX338cxt84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzU2NAGoCm0ZpuwWGc8OMmOqLEZ8AprNXqJc+3xDovLTv2mfdb
	kgHpscIUAWd2/1sIGYrmdIAyOo4Kr4OAKKe/GSshfBfLiRQta2zE1gw15ZzNvwlHom/4k55ijs1
	+51qNvDMyvDxWhkPdSDUTgl9pfLxZHaMhzGs2cILyP7Y41ChgjtLHWqO428zkWejlcw==
X-Gm-Gg: ASbGncsFBkcpMm5FgsmOSS20mmTQt86GgbefDpb5RRvt2syh1vvGzl/oJ/IIU5y2zfR
	DRSBdO1E60J8MCirADMQtpkjMLEcNISeK+Y4lUfv5e+kv22zypfYazopBQuMvIuw+Rvd6hRgYKA
	EY6O0h5cN0jTBQLJAiqdOc5m2UDS55fe0eSOnRSvJaxM6+7TaFbWfKaG9RTPu09UCay3Ley6FZ0
	HgouoICcEsIuGIcScUDVSkLu3F5IEPIJzUiHVnTAt8JbWWd1e/9EJ7RbL4P2Tjwl+HAzxQSNifW
	YdPy5IIjyU5ICX1mguVaHYhJKHocXCE5BluyrdjgCwXNuQ==
X-Received: by 2002:a5d:47c9:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-399795d8a4cmr2444038f8f.42.1742466321162;
        Thu, 20 Mar 2025 03:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFilRbQgcg6RKfKJHQWtM6ap5iAjquy8GFpgrzkvNWIO3lRerhAQf7zHt1rXURfOUeFjczK3A==
X-Received: by 2002:a5d:47c9:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-399795d8a4cmr2444013f8f.42.1742466320737;
        Thu, 20 Mar 2025 03:25:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbc3sm23193708f8f.88.2025.03.20.03.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:25:20 -0700 (PDT)
Message-ID: <ffc4c4ba-7159-4a89-be52-9802ef21153e@redhat.com>
Date: Thu, 20 Mar 2025 11:25:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] selftests: net: test for lwtunnel dst ref
 loops
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20250314120048.12569-1-justin.iurman@uliege.be>
 <20250314120048.12569-4-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314120048.12569-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 1:00 PM, Justin Iurman wrote:
> As recently specified by commit 0ea09cbf8350 ("docs: netdev: add a note
> on selftest posting") in net-next, the selftest is therefore shipped in
> this series. However, this selftest does not really test this series. It
> needs this series to avoid crashing the kernel. What it really tests,
> thanks to kmemleak,

As a net-next follow-up you could force a kmemleak scan and check the
result after each test case to really output a pass/fail message.

Also, still for net-next, please investigate if dropping or reducing the
many sleep below could be possible (it's not clear to me why they are
needed).

I'll take is as-is to avoid blocking the fixes for trivial matters.

Thanks,

Paolo


