Return-Path: <linux-kselftest+bounces-33390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F5ABD409
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E613B2745
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC2269AFB;
	Tue, 20 May 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckhuHOIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56274269D0B
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735212; cv=none; b=rnGNfGBNHrD9tbyEccVL6ZEJPPDAUvh/e9MEn8BsVdZJz5C7t1C7chxKfp6zo1RPuXlKpK4Phgh8ajvtImJNrRRsqpglvaM7V5Eo02x9D1GkJgN5A/LPHm3dbGa7EB9P/+tqGZ3pdkfJOoa4zMFn9HOY5KDft7CaQ6arvvYNuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735212; c=relaxed/simple;
	bh=V35LW/nQwrBSZ0SSHfv5/VHFhKk+U/HLriCmAgR3ptw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOLAOtwMG3PJ8rKrnKgyNuuO35kKrJXpy5vdzTrSi0y7Ih0SXVITwwy0GQLEtGP8J8MErKewQsrg87HUzNDS26wIRslKL7UhInJhjSlq+uwfxxWP2QMlhV1K2rB3oldyl3s6AH6Gu4Ic/Wa4MIwZTJsCFe8j11FY0lrZ7QaLo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckhuHOIE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747735209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
	b=ckhuHOIEnCaZgWJeKhe/0rY/Tq7NYM0KlYpCdW1rjzpANMKRxW9df3HaqALYqUXkADg3NA
	+8iTAAvPzjIYkMo6RTk/VoumhFUsdaCXhaTXau5LruONd9QXy8SYxJTn+iyTJjeC6yLpKN
	Goq0WKo2MK5scvyLamb7JhBM6RM7/Oc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Kj6HeiOdMiuifxNMWedtXw-1; Tue, 20 May 2025 06:00:07 -0400
X-MC-Unique: Kj6HeiOdMiuifxNMWedtXw-1
X-Mimecast-MFC-AGG-ID: Kj6HeiOdMiuifxNMWedtXw_1747735206
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a376da334dso893838f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 03:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747735206; x=1748340006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
        b=tsmRYG9pnZmOkJkGvFp3AxLLSLqzUmnqRLMgPnJokcbk3YQGLrsf9Zoh8PR3WyAJ1G
         DRbao1M/McTv65bb3BAt/8dAX389Lfxi2Q4/HLi64OXe2LMFFIf/3fG+p+S3yQg1RvJZ
         iQeM1aiv4D/HZFbmBmrVb83gvLzYZlB3DwQJptjSzQLNBh/NyxTd0kIKTx3iKEOjr24a
         hqhnUMbbZBAbFMBoMjr3myb3OSb0WH0hUGyBBb1PGWVQSVz8v5aKEXynf8K57D/9KKn1
         mXjyOjsS5Tz0Gf4gexT6WNmCgWP95HvrmYELxiqPdMLm3sDnA/o6V40cljk+xJkoW2XL
         mVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFk0IJ3826YPFpJjukAFt2lzuZJC3ycA6TQ++gyLgCBtAijdNoN7s8dPyRYeNHORuzUjpO75kSciVDIKpZT5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZz5mwmPhYMf6k64hriuAimKKjkcP/SJNNbahkFU8zuiEeNQD
	IJpgf/MDcIT6C5ulduoQWFeVPQA1rJ5d+e1zGddeFy6AUEHqtRO1NQ63BXdsEFpy9om+nnUF7a9
	X0tj6uSU18veGdszPIeS2O7eBWjUWKr3T9O1fmVTL2cAHfnwHd1UWb2Uyd4UyDTUyJLwmXA==
X-Gm-Gg: ASbGncv5QRiYGQYEtK6nammnUH14BGezE5bif625bAsmZ+wjTmSPCIlwt8WB9b0C8Tg
	jLeVPof+JLG9O9bMx3lQb/gf+uwHBj4YQ5bwtyLk5Zt2I0D7hI6qzRwrI10dV2ZFDdZSkm4+OO0
	Dm4ZloK7XWcD94QkcKJRznYTVbynbqO4GVhVUcmOIXtd4TDnSX3GpEb4ZTVoCnJ/x5cvcUQc242
	GlBrSi1xoKJLwprGf2auNknBTAETKyPGC395i9XRNIzu8AwTUnbmONz3g8++gHrtNY8nf3+vhgy
	oFafzg5b9fC39Z0Mu67R6YlpRT6+JEURVUFom2/ywB8FInDkajQ8qkSC4F4=
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495139f8f.51.1747735206374;
        Tue, 20 May 2025 03:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIRNWAVYHRnOH33ipWyYPABhiYG26BMzPeKKr8tdmXM1gGbvCqc/R+E0nOOiP3C8IUlUYdHw==
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495096f8f.51.1747735205976;
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a87fsm15500818f8f.29.2025.05.20.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Message-ID: <344a5b1e-9cfc-4a77-b55c-84fe21c89517@redhat.com>
Date: Tue, 20 May 2025 12:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 11/15] tcp: accecn: AccECN option failure
 handling
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -603,7 +614,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	unsigned int i;
>  	u8 *ptr;
>  
> +	if (tcp_accecn_opt_fail_recv(tp))
> +		return false;
> +
>  	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> +		if (!tp->saw_accecn_opt) {
> +			/* Too late to enable after this point due to
> +			 * potential counter wraps
> +			 */
> +			if (tp->bytes_sent >= (1 << 23) - 1) {
> +				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
> +				tcp_accecn_fail_mode_set(tp, fail_mode);

Similar code above, possibly an helper could be used.

> +			}
> +			return false;
> +		}
> +
>  		if (estimate_ecnfield) {
>  			u8 ecnfield = estimate_ecnfield - 1;
>  
> @@ -619,6 +646,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	order1 = (ptr[0] == TCPOPT_ACCECN1);
>  	ptr += 2;
>  
> +	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
> +							    tp->rx_opt.accecn);
> +		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
> +	}
> +
>  	res = !!estimate_ecnfield;
>  	for (i = 0; i < 3; i++) {
>  		if (optlen < TCPOLEN_ACCECN_PERFIELD)
> @@ -6481,10 +6515,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 */
>  	if (th->syn) {
>  		if (tcp_ecn_mode_accecn(tp)) {
> -			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> -
>  			accecn_reflector = true;
> -			tp->accecn_opt_demand = opt_demand;
> +			if (tp->rx_opt.accecn &&
> +			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +				u8 offset = tp->rx_opt.accecn;
> +				u8 opt_demand;
> +				u8 saw_opt;
> +
> +				saw_opt = tcp_accecn_option_init(skb, offset);
> +				tp->saw_accecn_opt = saw_opt;
> +				if (tp->saw_accecn_opt ==
> +				    TCP_ACCECN_OPT_FAIL_SEEN) {
> +					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +					tcp_accecn_fail_mode_set(tp, fail_mode);
> +				}
> +				opt_demand = max_t(u8, 1,
> +						   tp->accecn_opt_demand);
> +				tp->accecn_opt_demand = opt_demand;
> +			}
>  		}

Too many indentation levels, please move into a separate helper

/P


