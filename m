Return-Path: <linux-kselftest+bounces-37252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEAB04032
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F2D4A3C6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E687248F47;
	Mon, 14 Jul 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnb7P8KO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B436252903
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500037; cv=none; b=Qj87chNvvfhwcC41IcYrok4aiXETHVIk3w+8NL1ynlUSv2CVYoPpTvJsCZZD+iWnL5NIF+MaZ5qiiF5CFPckiea78gjHDaJ5pfE/wy0W7q1nC0zmeFpFANjHX8SgLlHVNNkfae4R4fWhtbeHYKqo7IcXwC/MAs4CMNG2bdGlGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500037; c=relaxed/simple;
	bh=dknSdYPDMo76cFz0sXYbOIhIT5DVtRwgwQqMWZ1ploE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hrK4izVuCRCGm081mDBnJgELyZjeRRqhsLxI4vCGCruzxfEn4E8vacqi5iDoaoees2ldt+lGwPqRKFKVWvSDeKa5qqeA/rtvvo6GRfIxf2520tlfHwMnbcG4hkfqa2jcLEgNAlA9En7lP7n1ntfH/qBKfr9xYG/0g2v5LfQrRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnb7P8KO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752500035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
	b=cnb7P8KOH1mqbeTfX0CvKavXh0N0chmRdms/Gv8BROhQdG2VEO2r4J8r4dC6X55kWZYwJ8
	+ZTtgRRlqAjhQI/IahAfALvUmFh1Jgx/f6fzSVkkfEFsLXX3qa+vLN7kCgq6ufteXMleYO
	4m1377AWTmYbpflttZL1ISpTyqMkIQQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-wfdA5wfkOjmjbNBXXlzGEQ-1; Mon, 14 Jul 2025 09:33:54 -0400
X-MC-Unique: wfdA5wfkOjmjbNBXXlzGEQ-1
X-Mimecast-MFC-AGG-ID: wfdA5wfkOjmjbNBXXlzGEQ_1752500033
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2104811f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500033; x=1753104833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
        b=GrrWUflAMmxsmhsYcQQArH7jHxdF8HgEA7IpmCdkKaP3LrdtfVmly00ShryPdEZVAb
         Nf27R+WuQuVaTBS66vPx1BdyY2vwfBvJf0sJiHJqSLyZoqGNFl/1M7vg/niW+6GJFDr2
         +IIxAmr/lqTImuhdRYK6SzWtb3AUMrHc3IaIQofg+WAVi2Iw88kAITnuUo60s5bi485d
         f4VTyOQ14xEykzFU6kmDxIqGmeF//QBWUQ+iwo4aypNKeZeIADAPZ22ljJH+6VHW3mxk
         oFgN9fWo+brGPX3SlWagcrbmfjk4gUhrOao7ukHH3mJZeHvO07OdP/3jDjK5l+F7AypR
         jAuw==
X-Forwarded-Encrypted: i=1; AJvYcCXlGOZqaGOo7mza1kVS8SCJUcza9RbJa/7d+9GOvati1QuPilDrdExDeFYqNL0nEZniKu0WhK+6tdlQwgWbPls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKSskP+PK6fxEusw8j0o3ng/M5uVvs5ENLN3hK46N+ZpK4e2/
	blos/1gris4VGRlCRRZJxiW+RtBuvIIbw+Gq8fWDUfZnpJo8ey76Cdx1DbJzn+MjV65ApvTg7iq
	SLEBMM4YMKmRBRJ3DYcmnkfd81eS8/Y2h2lVEyyrjkpjEWWYjJIDd92YLR0CMxIc8eD34mQ==
X-Gm-Gg: ASbGncvUoJnHsltf/ks7iSgasUpWzBdjcNX43hD/E87WZePAAXK9dxQyjQPxxYfJwnM
	gtmGAICwwtIcJFrTT3S+LG+hewB79flSyxyMpTvWKcvzFL1PfqzWc/aE4KSSSusH/QZGyJKqXnl
	z9ZVfEtykNkIJ3j96trmoNCxF+EVzjCIOZfreoEn2js925TjiNakc5AcUte5DoMJ/FS8Ht/soUP
	L2fryj106f51se7MvlzZizfollu2Uc29DsxnYvGjxNbkT80sEcSuk99rVSD4Vn2FInxUowmu5wR
	UyUGsbIy+ZMCV9bzVxft37vPcng+9uIgGeHfSTZ6lTk=
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445141f8f.34.1752500032647;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcwfUCJlkG4jBfS0/HPnRj2f8oJvU/65bj2WaKyheEy4Aut2WkWbMl50W+qZ6Yk9d4ozuegA==
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445096f8f.34.1752500032183;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f22sm12633688f8f.94.2025.07.14.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:33:51 -0700 (PDT)
Message-ID: <226c49dc-ee9c-4edb-9428-2b8b37f542fe@redhat.com>
Date: Mon, 14 Jul 2025 15:33:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know
 delivered bytes
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eea790295e54..f7d7649612a2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1050,6 +1050,7 @@ struct tcp_sacktag_state {
>  	u64	last_sackt;
>  	u32	reord;
>  	u32	sack_delivered;
> +	u32	delivered_bytes;

Explicitly mentioning in the commit message that the above fills a 4
bytes hole could be helpful for reviewers.

Otherwise LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


