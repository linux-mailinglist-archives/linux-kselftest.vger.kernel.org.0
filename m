Return-Path: <linux-kselftest+bounces-37409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF0B07094
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F174B50619D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D42EBDF9;
	Wed, 16 Jul 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUQHXOu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3552EACE1
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654578; cv=none; b=mO8FWDIxSVesrwexUfBaFwPGAl5IQNTSvXi6aVrlVjT06FO8NGTh6N3Vc132VHVFG/uvjdUgOhOSAFz0fAyzs+3Vl/qZ4jcVhyhCmzfAseQVFZWr8vo/LZkzj30JyjHqcvlBHIFUKraN46Krjjrw+ZAtcC6qwwOkw+fUF6RyOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654578; c=relaxed/simple;
	bh=RXd93FrMXhD6nQlRw5UhfdK/Fc7hARdOf1IOkW55cdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oKwzTTV463+aPwWNUpr73WmfloL1Cb0eLXGfXzPak5AS7baqze9SefFIXN8p5+ciszPJh7olWmeqR8n0pX4kVSOHViyKMvWoBDClUtrLMz+9x2SqM1YTWKvzWTaK6UF5XiymW0vUU0seWpZvQQ3tXY8WE6ZNVej1J8Q63lLeQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUQHXOu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ffz+MsDbG4Gm1eq6U3qZmEbUy+20PK+4pgl+eju8lOY=;
	b=eUQHXOu4i20AEyHyclVjvy0nsSasjq3HbXfCEaJVROZ7GNV9xx12K23+wKCE5ubpo9Oh+B
	uBZMbVWdKjM8ig4e8KVAkhSGawLK2J2C0uY6BtC84cIsIcwzGeDUi2JpX0TJnUDgx4PY3X
	lF81C04EAsPoNPV6IfEl71AMuyZd0uo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-MfZI5zqiP1O4GgIYBVqIaQ-1; Wed, 16 Jul 2025 04:29:32 -0400
X-MC-Unique: MfZI5zqiP1O4GgIYBVqIaQ-1
X-Mimecast-MFC-AGG-ID: MfZI5zqiP1O4GgIYBVqIaQ_1752654571
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456013b59c1so24099195e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 01:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654571; x=1753259371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffz+MsDbG4Gm1eq6U3qZmEbUy+20PK+4pgl+eju8lOY=;
        b=YvjeXfF0/VzCvyNqEhXWowT7V+TtLd+HZouBYAnoDxM1NRYN7rCsWJbGrNXDuy1rvA
         7OS8tNh+QTgzPrHwocHVZ/Se72wIrvLeDyEPG9MBwicl09GLzRDmNI4nYk6JsHqTPJmq
         oOmR34Ry7OFJqDVGcyR+xPTygK5fq3BVBEx6+1Qpy8Xl2JATf0XhWeBoYxQYlzrax/Ob
         OPKKl8dx0rcvlUwiSpTCeV/pOntszB0XB4eH1fMcPg85lMetGhMOjwUWq4/VUKtH7P69
         qzC7qXmMKb9S16Hsg47fYg94i9ybkjG7YIRjhTKAcZWtW05QKdNXgVil9fbIthNnNZPm
         H1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUgyjH+TM+Vso8+qcvApQTA0Bobrr6maeT8gBULGEVlPwdczfcR9wmjSxAmuGbn3TfpWnRXP40LM4b+hXHy3mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpVceOqadP0gbcRZYnlv8Jmfpy69TCorzv0jwoh9n1yeijYvC
	+sCAcQnJ+W2ZIZvIRxP6EImqHeY3QAIBgSTQDhjPLuGTGE0wDWrpypTK3SrGdBGS3VjZbhkcf99
	oENiueROfGqBEH2HGWNz5Ta+PrrAi/ekdaYfX4wnw7wz5x9NzcIh8IhDN6bwOYh0fHA2zhA==
X-Gm-Gg: ASbGncuBVJb7lC5swNZH9h5gRv9V26K34Q4afGzAfWrSe0m39rhMwTya4aFPxGpvypg
	AQEyQbKwB1wUUlZpWNkUyELfIoWPhFTDPU5qnYV01hj7MGdaqO1TQjWZ10EKAY5c8z4Hs4ETQFO
	1ctg6K4GiD6vTiNBgFiq7WyKPG+KpnT8SRswelxgJoEHFjE3Guk66Jbdd1q09e9NATyJ4q4Uxi+
	NlRG5ia4kdDTonr+Dj41grM+HRBddEVWS19h+v6TVzbgK0MkWQJE8v4SOV80B/EbAJqRJCy5RQp
	Lw2G6jbFOv84DqiWjwvIZt9oFmmjoA+941gyI8R6kNCYdbxbbRD/4vJOXyY+bbqacJGaUq2NAYT
	lo5oqRaNyBfM=
X-Received: by 2002:a05:6000:3113:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3b60e4c225fmr1234136f8f.21.1752654571245;
        Wed, 16 Jul 2025 01:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLiGksmElCYFmj6deUhZX70Iugn3d4BK4R3BF8eDMEuaPTLbQdgfRYY0kjWfYoS6K8Me3pxQ==
X-Received: by 2002:a05:6000:3113:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3b60e4c225fmr1234094f8f.21.1752654570753;
        Wed, 16 Jul 2025 01:29:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2cfsm16961144f8f.75.2025.07.16.01.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:29:30 -0700 (PDT)
Message-ID: <f60c5ef5-47b6-4132-bd7c-9707c81289a2@redhat.com>
Date: Wed, 16 Jul 2025 10:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 11/15] tcp: accecn: AccECN option
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-12-chia-yu.chang@nokia-bell-labs.com>
 <0ddc5daf-adb4-4d97-9e8e-e60fdf9a007f@redhat.com>
 <PAXPR07MB7984F66EB2AD576D2385C351A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984F66EB2AD576D2385C351A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 4:49 PM, Chia-Yu Chang (Nokia) wrote:
> On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> [...]
>>> +}
>>> +
>>> +/* Handles AccECN option ECT and CE 24-bit byte counters update into
>>> + * the u32 value in tcp_sock. As we're processing TCP options, it is
>>> + * safe to access from - 1.
>>> + */
>>> +static inline s32 tcp_update_ecn_bytes(u32 *cnt, const char *from,
>>> +                                    u32 init_offset) {
>>> +     u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
>>> +                     0xFFFFFFU;
>>> +     u32 delta = (truncated - *cnt) & 0xFFFFFFU;
>>> +
>>> +     /* If delta has the highest bit set (24th bit) indicating
>>> +      * negative, sign extend to correct an estimation using
>>> +      * sign_extend32(delta, 24 - 1)
>>> +      */
>>> +     delta = sign_extend32(delta, 23);
>>
>> I'm under the impression that delta could be simply:
>>
>>         delta = (truncated - *cnt)
>>
>> What am I missing?
> 
> Hi Paolo,
> 
> I think this code is necessary to ensure delta will not a super large value in case of wrap adound.
> 
> For instance, if truncated = 0x0000001F and *cnt = 0x00FFFFFF, then (truncated - *cnt) = 0xFF000020
> 
> But sign_extend32(((truncated - *cnt) & 0xFFFFFFU, 23) = 0x00000020, which shall be corrrect.
> 
> Another example, if truncated = 0x0000001F and *cnt = 0x0000003F, then (truncated - *cnt) = 0xFFFFFFE0
> 
> And sign_extend32(((truncated - *cnt) & 0xFFFFFFU, 23) = 0xFFFFFFE0.
> 
> In this latter example, both are correct.

Ok, I missed the fact that *cnt is a 24 bit integer, too. Your code
looks good.

> 
> [...]
>>> a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c index 
>>> d98a1a17eb52..2169fd28594e 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -385,6 +385,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
>>>  #define OPTION_SMC           BIT(9)
>>>  #define OPTION_MPTCP         BIT(10)
>>>  #define OPTION_AO            BIT(11)
>>> +#define OPTION_ACCECN                BIT(12)
>>>
>>>  static void smc_options_write(__be32 *ptr, u16 *options)  { @@ -406,6 
>>> +407,8 @@ struct tcp_out_options {
>>>       u16 mss;                /* 0 to disable */
>>>       u8 ws;                  /* window scale, 0 to disable */
>>>       u8 num_sack_blocks;     /* number of SACK blocks to include */
>>> +     u8 num_accecn_fields:7, /* number of AccECN fields needed */
>>> +        use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
>>>       u8 hash_size;           /* bytes in hash_location */
>>>       u8 bpf_opt_len;         /* length of BPF hdr option */
>>>       __u8 *hash_location;    /* temporary pointer, overloaded */
>>> @@ -621,6 +624,8 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>>                             struct tcp_out_options *opts,
>>>                             struct tcp_key *key)  {
>>> +     u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
>>> +     u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in 
>>> + succession */
>>>       __be32 *ptr = (__be32 *)(th + 1);
>>>       u16 options = opts->options;    /* mungable copy */
>>>
>>> @@ -656,15 +661,79 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>>               *ptr++ = htonl(opts->tsecr);
>>>       }
>>>
>>> +     if (OPTION_ACCECN & options) {
>>> +             /* Initial values for AccECN option, ordered is based on ECN field bits
>>> +              * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
>>> +              */
>>> +             static u32 synack_ecn_bytes[3] = { 0, 0, 0 };
>>
>> I think this does not address Eric's concern on v9 WRT global variable, as every CPU will still touch the same memory while accessing the above array.
>>
>>> +             const u8 ect0_idx = INET_ECN_ECT_0 - 1;
>>> +             const u8 ect1_idx = INET_ECN_ECT_1 - 1;
>>> +             const u8 ce_idx = INET_ECN_CE - 1;
>>> +             u32 e0b;
>>> +             u32 e1b;
>>> +             u32 ceb;
>>> +             u8 len;
>>> +
>>> +             if (opts->use_synack_ecn_bytes) {
>>> +                     e0b = synack_ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
>>> +                     e1b = synack_ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
>>> +                     ceb = synack_ecn_bytes[ce_idx] + 
>>> + TCP_ACCECN_CEB_INIT_OFFSET;
>>
>> On the flip side I don't see such array modified here, not in later patches?!? If so you could make it const and a global variable would be ok.
> 
> Sure, I will make it as static const global variable, which I hope this is ok for you.
> 
> 
>>> +/* Calculates how long AccECN option will fit to @remaining option space.
>>> + *
>>> + * AccECN option can sometimes replace NOPs used for alignment of 
>>> +other
>>> + * TCP options (up to @max_combine_saving available).
>>> + *
>>> + * Only solutions with at least @required AccECN fields are accepted.
>>> + *
>>> + * Returns: The size of the AccECN option excluding space repurposed 
>>> +from
>>> + * the alignment of the other options.
>>> + */
>>> +static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
>>> +                               int remaining) {
>>> +     int size = TCP_ACCECN_MAXSIZE;
>>> +     int max_combine_saving;
>>> +
>>> +     if (opts->use_synack_ecn_bytes)
>>> +             max_combine_saving = tcp_synack_options_combine_saving(opts);
>>> +     else
>>> +             max_combine_saving = opts->num_sack_blocks > 0 ? 2 : 0;
>>> +     opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
>>> +     while (opts->num_accecn_fields >= required) {
>>> +             int leftover_size = size & 0x3;
>>> +             /* Pad to dword if cannot combine */
>>> +             if (leftover_size > max_combine_saving)
>>> +                     leftover_size = -((4 - leftover_size) & 0x3);
>>
>> I *think* that with the above you mean something alike:
>>
>>                         size = ALIGN(size, 4);
>>                         leftover_size = 0
>>
>> ?
>>
>> The used code looks quite obscure to me.
>>
>> /P
> 
> Indeed, I will make below changes in the next version by using ALIGN() and ALIGN_DOWN()
> 
> Here the aim is to pad up (if max_combine_saving is not enough) or trim down (if max_combine saving is enough) to DWORD.
> 
> And the final return size will be the the a multiple of DWORD.
> 
> Would it be more readable?
> 
> /* Pad to DWORD if cannot combine. Align_size represents
>  * the final size to be used by AccECN options.
>  * +======+=============+====================+============+
>  * | size | size exceed | max_combine_saving | align_size |
>  * |      |    DWORD    |                    |            |
>  * +======+=============+====================+============+
>  * |   2  |       2     |         < 2        |      4     |
>  * |   2  |       2     |         >=2        |      0     |
>  * |   5  |       1     |         < 1        |      8     |
>  * |   5  |       1     |         >=1        |      4     |
>  * |   8  |       0     |         Any        |      8     |
>  * |  11  |       3     |         < 3        |     12     |
>  * |  11  |       3     |         >=3        |      8     |
>  * +======+=============+====================+============+
>  */
> if ((size & 0x3) > max_combine_saving)
>         align_size = ALIGN(size, 4);
> else
>         align_size = ALIGN_DOWN(size, 4);
> 
> if (remaining >= align_size) {
>         size = align_size;
>         break;
> }

Yes, IMHO is more readable. No need to add the table, the original
comment is clear enough.

Thanks,

Paolo


