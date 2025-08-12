Return-Path: <linux-kselftest+bounces-38769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2191DB225A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C90F566851
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3952ECE9F;
	Tue, 12 Aug 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyqkqVXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2692ECE98
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997175; cv=none; b=T/i/m6K4HdIEfBf92Y05HzlxBGt+PjKAh95SJY1bBDBf/hdPFhhc0glOSFdpwtjuRT3fvr+BfLjNRhmS83gWn7OAInjQwTYIbBLnSprnwc5O7rBOvy+gNtCV+1wbFFJoo7uQpcf30BdDgijnAUwyHBHCrgUe2v96cn6cfKfVTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997175; c=relaxed/simple;
	bh=mAvVdXFly3RzYhUX9cv/kny4RZRWhC1AvwC2a27uNmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FW5PqeYniarE/yHDdLQ8YRp6olW9X7M0ps/LzRRJTA3JQtfYVJaCRPfq10gfkcC0VtCo4KY47Ax3Uo6HIk12D46VMC2o+dtI1esRnHrPCL6BSKBb/RuQglYxOKBNbWVh9172qg1uYp2Po87yEo60XeTAylYm+4EWjVnhAFxwxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyqkqVXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754997173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//obXwMFuZhQYhGTHbbzXxbGp1uJw0doBZ0Gzmkr8to=;
	b=SyqkqVXD2Whn/B5uuwSyAEXc2GW7WJKxP1noZNuXqZ03ZlVdIvrE4286j4ctpI02+UgNbs
	LxVJbj029KpbsQoLY4y8635MavYiMYeVOkXXagNCO0YJp8prsTGZXyyVS2geyk36uPTcdq
	rN7TK6IJVDArQ6eUUeN7rzsLqIo/+BQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-z2NO4fCSPuGxuLLybOE-ww-1; Tue, 12 Aug 2025 07:12:52 -0400
X-MC-Unique: z2NO4fCSPuGxuLLybOE-ww-1
X-Mimecast-MFC-AGG-ID: z2NO4fCSPuGxuLLybOE-ww_1754997171
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af210c5cf3so213089651cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 04:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997171; x=1755601971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//obXwMFuZhQYhGTHbbzXxbGp1uJw0doBZ0Gzmkr8to=;
        b=lrSzyQN9wgyPa25rkqRL5TKrdmJ6jsxxwTozfWPZKeMKQvu9Jwl5kDI7D+7zn2L0dL
         8/0CQacfYRA/m5eJP3Y98n2Cbw3BthY0WAGj/2cvwrjXIqiUlb2zzP7nOZYMaPeW51fn
         LnmfTj9R4i+G6IxNagm3MOXJaZ+dWnceLEzqGUqTiy5vuIHb3jCnkUaHNV68gBjdqto7
         D9dxPBLppGdEFLTq/yg8d3a1ZZyKEuxYjfD2gcyHj65UA0vZQBG2MKfBkP3cxaLxB8F6
         tYjei0zeTfcpMaPB3dFl1Qss7uWpv713OQbk6NUhgNzrsUVgUo/XZqrQQWaGniY5lMX9
         F8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwFPrsDk+lOVrRe2OUrNGCEZeqYT6YIkuRaEJ4nvYv01cf67e8eMG6/xSeidgHOk2bfjXuzNwQvAObOiy29Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1k0x0oNSznlCkSVBRqYKLg8aBXY7C7iFEOmGE4ad+yKrpJtbZ
	9mjKr9Kjst8e5S7mEmrjdVGhdUHR6GKEiqORdWyY06H0umQLlEwpcZjzdvXmxdMiJ0qv0VqM4RU
	VDL2L4kfYASR2mTxwhukxh6D24PrIIs83G6SORh9HW6fFg2Lcd7SHNOj6MjLOVCIqbBinSg==
X-Gm-Gg: ASbGncuuLxjC12kzrRV+cCS+76FxsAplOapBLsSMvG7TbR5riekUb9Da8XiKUc98+xQ
	CKYM6a6pJPS9vnXFSe0Ea7d9SMjdtpdo58ug6eeBlIyRIe0Zf5RaCOvR5is9YUgt4oPWCPQE5Mw
	9dLjT56fzdwHnFxl+6PMsmvNs6wObpIpeNzruv75fnsCBbBoYcsi5Z+fghkebI4+F7IIkjregRZ
	8Dd4tn9HVHOkQZ4qSunpNmFKEs7Yd37AzKovr+bGw1tAnmfe0+oRrG7T+QE0gnjFGuRFHryneJz
	4EdS+QbG5aeZegBWuNHz6yVOlBVKc1Qt5fhkbIUJmNE=
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr31187801cf.26.1754997171408;
        Tue, 12 Aug 2025 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb+GnezAp313Oe/VC6buWBT5Gei+SEerxd7EbVFtjv+1zgncHD2Qh7dygE7luAX2P9hrw08w==
X-Received: by 2002:a05:622a:1355:b0:4b0:6e11:c38d with SMTP id d75a77b69052e-4b0ecbe7076mr31187401cf.26.1754997170894;
        Tue, 12 Aug 2025 04:12:50 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06a86735asm120286161cf.31.2025.08.12.04.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:12:49 -0700 (PDT)
Message-ID: <7c011a2f-cdd8-4aed-95b9-d8edb31478a7@redhat.com>
Date: Tue, 12 Aug 2025 13:12:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: wait for carrier
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
References: <20250808225741.1095702-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250808225741.1095702-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/25 12:57 AM, Jakub Kicinski wrote:
> @@ -48,6 +51,19 @@ from .remote import Remote
>                  env[pair[0]] = pair[1]
>          return ksft_setup(env)
>  
> +    def __enter__(self):
> +        ip(f"link set dev {self.dev['ifname']} up")
> +        wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
> +                  lambda x: x.strip() == "1")
> +
> +        return self
> +
> +    def __exit__(self, ex_type, ex_value, ex_tb):
> +        """
> +        __exit__ gets called at the end of a "with" block.
> +        """
> +        self.__del__()
> +

pylint is doing what looks like a reasonable complain to me:

tools/testing/selftests/drivers/net/lib/py/env.py:65:8: E1101: Instance
of 'NetDrvEnvBase' has no '__del__' member (no-member)

/P


