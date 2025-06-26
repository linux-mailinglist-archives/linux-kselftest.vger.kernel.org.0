Return-Path: <linux-kselftest+bounces-35859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319BCAE9E49
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0039F1C4130A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B492E5406;
	Thu, 26 Jun 2025 13:11:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3268BA53;
	Thu, 26 Jun 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943504; cv=none; b=saTfguPLV5u+1Wz5SZUe+iadbEDw/6fpUlt+/pN7h4FZhqugCNabet45gvKMHrebmfgxwtCJ2tshCXvvR7d/UbhoetpudYgIpJmxKPgcy0AhueZNdyJCXvogh05HFOZlt6ZfYyOUL0ayqEYB8OyUqw5oKy32A1cxySluaQ9pd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943504; c=relaxed/simple;
	bh=w4R8iE9Etaj8vE0EPRYSb20owInwjnYMQe4bxjHwmNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKy7uxldQOFrKM0YmIU1I/bmZxZWVfyC9cnLscayMYtHzz2cbUbYJjowJrFZJfHUC8O3xapxEYfzMQJX2fPi8tigjX0ayxmanxYhRd9FU33J15VK+OFZ7/jgbYbHeaFtw/IXHmEjhp7VftPZNYb9BQI2BgJj3XiWuV4xzaKQuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0d11bb2a7so134713866b.3;
        Thu, 26 Jun 2025 06:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943501; x=1751548301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKrijvnpltMRSzKIoATVRkabKx2dUSossfMtdJuR1Dw=;
        b=OitYZ4InaBy4PBdMdLc5vRFCBUV+HpiXYto5OKaOFAtTqWy2E+BqiE3amD00b5OabN
         2cstV+S/48KF8cfNnoG9pdt4fGW03gotiwNFqgyI0GvK/UtvTHJbrK+6UiwA0gIXC6ZE
         UbRnNqcr3KWvxG43xBoMt6pQ6OiNbK2//llBJRZwfuprrs23zPtwRfwELpfZiLUqgATr
         9hmMkM+elSRKHq5SWJnwgMQsCcPr+bSLA/Lwm/3/jLIdE8zXZG/LSMdLxrz6/unh7zMm
         IMV6RiML3uT4ol+35Ix91mUj+8H7ueo0E6NxDARTxy7jxiu8t/l8S80Fxv2Cv66qoJNb
         TPZg==
X-Forwarded-Encrypted: i=1; AJvYcCUlNNBTMc8PUHz/W1YHorJ73uO8wk/DXulwh8Im4By0s+yD3++z/SGwVQvOn393g4WFSVE=@vger.kernel.org, AJvYcCWAeezN0FHuuDFejIxdB2Eocmv0tjUW9e2dmTM77z/LtZgZ2pDwKEoRl866+Olq796YayKSFhMUS8nQdXdkTLGM@vger.kernel.org, AJvYcCXPcw3JK7maDSG224z015L/an8rVILhbPEZw7A/vHyDiHg/F3Qj1j2hEeTaFgGZMvmDzORm7zMB@vger.kernel.org, AJvYcCXY3wbXDlaCJFuKT/LD85kPWYW/w0zXHHjd9zAfFNRPY3MhueOWX0VEXieNJuTUaukKDZT/7OL6pwLnzy/A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj/vAlt101PUjZke4/AJ8GfNiSLl7AlMqjTMtLCFb5ix1wRwa
	725hghBNisvr9ndllsWnBWbqasvDJ4XiyPO/D5+lK690jwQtY7N1QhHp
X-Gm-Gg: ASbGncue7k2YXv/h84b/0WsJmK3d9OJk+UxYztx/s5cf8IxBEYqZXzZ1jkH8MJAF05I
	M6VcIr4qhWbyWS5AzGeJQslXHf+rQXrY8gjLhTS4FezEgNnMoAPR2OQV4ANcspmCzlCdI6EX7oT
	jvFpJr9yjR48UxLeV8AVe74OlQSadz8TNez3wVr0ezFO63yizBiAs1yymnhfPn31N9jPEONhOL3
	7zMGlaG6o13MAkydl0fx6ucIU4y1CJ23o6HzD2YFKRMlFyPHByuYCJFtLJoptI6ArJCcfkBPW8U
	xkRG2TQMLmL71jZnvzb3KCun3NIulsrKMNDQSRjRgxFdxKXKJt2H
X-Google-Smtp-Source: AGHT+IGSuadEaVgkagUU75lLfEPDaKFCaLC8s8d5gy+Oc1jGkZNRizV4QSXoUdUJXH14S4b0PXQF7g==
X-Received: by 2002:a17:907:fdc1:b0:ae0:cae0:cb35 with SMTP id a640c23a62f3a-ae0cae0cc63mr488065766b.37.1750943500846;
        Thu, 26 Jun 2025 06:11:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0bccb4379sm340925466b.8.2025.06.26.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:11:40 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:11:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 2/4] selftests: drv-net: Improve bpftrace
 utility error handling
Message-ID: <aF1HCmA0KHG/Gb62@gmail.com>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-2-47d27775222c@debian.org>
 <20250625144816.5cbc9298@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625144816.5cbc9298@kernel.org>

On Wed, Jun 25, 2025 at 02:48:16PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 04:39:47 -0700 Breno Leitao wrote:
> >      cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
> > +    if cmd_obj.ret != 0:
> > +        raise Exception("Warning: bpftrace command returned a non-zero exit code.")
> 
> cmd should already raise CmdExitFailure, unless fail=False / fail=None
> is specified.

Oh yea, even easier. I found the code, and it is much easier to just set
fail=True for this case. This will avoid hidden errors.


