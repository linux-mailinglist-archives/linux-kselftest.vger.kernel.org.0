Return-Path: <linux-kselftest+bounces-43369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE09FBE7493
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7FE18958C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AEF26F44C;
	Fri, 17 Oct 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJu1Ta24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8602D5A14
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691028; cv=none; b=Xmi+9I6YGVYAoaxcGhQJ0sLrQi2saJdJQY3Ng/h8Id73XyGnWvy5yE9LIAzhtN5EOABbTuDn/HwnLsKc0YI6guU/lm3E1CAFPKsP6S5HDZyg83jUIvP9C/hnIaROTtFPXAS1bvJgsJjVid/ck03jw/euf9wXc16Fw9YaBnLOSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691028; c=relaxed/simple;
	bh=YYPBQlX7Etpjm7s7QEscaxhTtIcXv6bNblJxH9enR0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQ/T1oHxzWvc92ijkFPG/OwiajMPALyT3u7vQViXMTqLQZ/uP/CLBrSh2gdZsp4CCaTDpNuYP4N/TVtOLF5d+2YzUqXLJ4GGgx2l3yh89lTUKp2hbvjQsUJ1Juxf/ucJGl1DhhIRi8/9qUAspaWMvQRpzOIilQr/p/YgEpZCUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJu1Ta24; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760691025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
	b=DJu1Ta24ahKMoRqhPP3N2PFiKjXV20yFSnq8kl+e/VHV59nwyVD7BV4MBxegE74eA1QPed
	fhRgmjGW2raXTiymp83aSFEIbQi0JNS7kUyBClEDYZca5rjvcat+NU6IfUmzuTHJK4+qgI
	4BZyegm3gO2ju3NCYTueG4jpWJ2GEl0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-zyHkLk8_P1WBXhywTReQ8w-1; Fri, 17 Oct 2025 04:50:09 -0400
X-MC-Unique: zyHkLk8_P1WBXhywTReQ8w-1
X-Mimecast-MFC-AGG-ID: zyHkLk8_P1WBXhywTReQ8w_1760691008
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so1053683f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 01:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691008; x=1761295808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
        b=Y6NjfDWla4la3th8x9ksC2i61WqmZlIOZ76G5nvHslSVIsr9MmvhyZo62erwiTR03f
         0S2jWGfQN4z1Sey0vx6fOxOjyokdhTqqUL5xxCQHJmZPnaRNTne2IYDJW0WDHYMNyG3V
         07iKb34iLNEejvljo4IF2PdlEoDAvxd9zTWrXgQ1Rm+RphnsCzToFV/Ny38w3ra65Oqa
         W5P7KEGSg3SB/8dQBuTNqlHr0WYu3CwiZUgHXWeCg0fIfTn3jQlTz3G8tfhsGjlAJssu
         lu7wrh0ITLqFZhqPfInDdNwhuzdDcf0K4kXK228vxMlmBVGVlrJY4cSn7i35rIhQyL1d
         HB7w==
X-Forwarded-Encrypted: i=1; AJvYcCXOfDD89i6lxPnnOM6nBfKj8AIXZKWkZILdJMwWc+6FCALnAWAEtOpEx4YmIN4ugUfCUAr7cgK5itEjPwa4U20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PWcGmimHcxR2fagLb8X/HS4fLntwq9yJ+oarQ3waNAS+V3XM
	9nZ56vbJ71YesclVe6Un5xVe7sMi9FbqEpvzAIhteO2oaWjGLASTsDi6sFuZFLjvvSh5aQu+v7p
	Uav7EvH4SRSaHrgoT7JexsOtmVKK83BzuDok/WQc07li68kPAbVrFKSLKWsRPpxCopcxUhg==
X-Gm-Gg: ASbGncuLu7m/Jxjjx4h5N6KOSCR5HZ/Ze1AIThkx/QL4lfcQ9D73AelTzDOMQDKKbyy
	n19uEbjgwDkrqU+l7IEryWwuW2xfVqegbgA6VKG32M8yjLNAjPqQxWnXXMadjE1lnQI/11hP8B5
	Fb9u8uDVMYBQO5VPxOcLX3Km555KZYfzobP6eJzhD6AmNbf+vqZa+XANjFNtgWPGRbS9n+Vip/B
	4aPaFIKOPmksNNMACNNwY02x1CD6p72JjFFCrLH1k9vGHqfBUKYEaReDfyaI/Ojf2qgxlsP+KVV
	7oXZfOO6a0FrXkogWVy07PNpce3mQExhEtsOZFPFj/v8WqYaaf1aBEGtf8AF0va8ow8hkKZ1RTD
	BbpUqDK/9Fgc1it0V9wB2x8sz
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848413f8f.30.1760691008305;
        Fri, 17 Oct 2025 01:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPn1Bq51EEjEp3mbuDuZJdQmHmvxSk92khzwK9w79un3eDQHfNQFRXeoDtb5mSWq1kC9Os9Q==
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848383f8f.30.1760691007930;
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm38047624f8f.26.2025.10.17.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Message-ID: <c6b17fa02a82c61a64abaf6c0abb5154f79c4fbf.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 17 Oct 2025 10:50:06 +0200
In-Reply-To: <87o6q6vuyj.fsf@yellow.woof>
References: <20250926094613.34030-1-gmonaco@redhat.com>
	 <87o6q6vuyj.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 09:38 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Add a series of tests to validate the RV tracefs API and basic
> > functionality.
>=20
> Thanks for the writing this test. My bash knowledge is not great, and
> I'm not familiar with the existing ftrace test, so I am not able to
> review all the details. But looks good as far as I can tell:
>=20
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks for the ack!
I think that's good for now as it's going to go to Steve as a next step any=
way.

I'm going to send a V2 with the following change just to increase the likel=
ihood
of a wwnr reaction and prepare a PR.
I'll keep your ack there unless you explicitly mean otherwise.

Thanks,
Gabriele

diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index bc0b2668bf7c..5a59432b1d93 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -4,9 +4,10 @@
 # requires: available_reactors wwnr:monitor printk:reactor stress-ng:progr=
am
=20
 load() { # returns true if there was a reaction
-       local lines_before
+       local lines_before num
+       num=3D$((($(nproc) + 1) / 2))
        lines_before=3D$(dmesg | wc -l)
-       stress-ng --cpu-sched 2 --timer 2 -t 5 -q
+       stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
        dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr d=
oes
not allow event"
 }


