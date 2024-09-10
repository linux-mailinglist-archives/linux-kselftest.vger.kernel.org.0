Return-Path: <linux-kselftest+bounces-17646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC029742A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793A3289B70
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F31A706C;
	Tue, 10 Sep 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNjTfkd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123E1A4F3E
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994205; cv=none; b=na9JXueX29I9ZC+rMKm/crR/lHTttsGLyR1cRHcCbYZ+EOeWOYF17lXJ7on+uanfSxK/woJhzjTk4ni4nu3GeLHIU9pDI/ZexFjIBph37+E/BQ74cF9vYOncVVj7Gn9cF13h33tjYsgPYjeawuDJtrV1a7EERYTV+ephQqrbdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994205; c=relaxed/simple;
	bh=itBQXuelZA75Po5d9GzHrmHgnyq5aLaPbElZSW4ZNp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe8kbUS1gV7IGushRrzLVEDFHWYgfwnaCytj562ouQs3S5QzBl/+wgws3pViALZ8l9+ICRrk+tZ4LFlcVE0uaaM6+WW3zC5DghxgY6XZfjgFsKF8UMsodMCWql8WaTWVTqrsB3WF9CwYx+HB1r3ZEkUHvhxWFXOfI4w+apsGoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNjTfkd/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39f4ec52c5fso22872835ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994203; x=1726599003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=NNjTfkd/VBvsEsDkvZs4/SFKOlXxY9n/nJwRU4T/Oh1dkJVSiY1dd0wOYZuLBRCjGh
         shqIRGc+oAy9hftapFPap2qFzqXodqlrjAOBzo03SFegy52EDqPRcpVh5LRjrIal2ex+
         zQLN+Ipn3WpoREZ4JaDBbzPfuEV7CfP4zqYtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994203; x=1726599003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xzLBxLjgDj5rpC/iK1MnqiUkc34ZYC9aNRFEI6xVyM=;
        b=Y4TsWNQ18V2/7hhZ2h7bc1qwBVDZdXeW1xNT1MRlUQGr1bmgumkIag/qx1DhVevbOS
         N8v/bkmr/qO4i5PD9fH9/r+EBkNPawd+8JH4KQG724fdmw0NhjWoia+PQyfxKmQaNdSe
         O8WRE3c21ZzJ0qzw+gt6GUsUeopPB7rVBN8EgT0/11tDJbiVy6H3Ir42UGwJ9HS2i1Cn
         YmViCQuHPJygKLwyY2fW1rUElN/z4I0hbC8WAgl6DHdplEPFXZquj+OdmfpQCj+zQn7/
         FJNl8lPDKIyZQ57CCX+eX7aOqwaT2dgmQCKGSLhGLFgFlUcsvo+XBNIZw4RdTvVC50sd
         OHPw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPM6/Z1jfwuzmA4QZ+Mf14qLtBhuO7LMy3tu8H/J4MbE+97bJdKgaLVAQu+fiNYcG5JTNHzOMuEsrUhSZAbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlg3HdQyqkR/W7S0WTWmIkRMCWnwuQMW6UZW8AX/jqVofqF43O
	N9GkFNgJhEyMjAhn4UOj9hk2ulDmz43dUGnhgRG/orIjIkq4mp/vVAz/xlAKG4A=
X-Google-Smtp-Source: AGHT+IFDdvfVtJxuoA+NPIZaRMPtLiYE16oR91YzbeNcdA/bJHDFPaffJkkcudyfvCuPdeiV0K22Gg==
X-Received: by 2002:a05:6e02:b2c:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-3a04f0758camr187994025ab.6.1725994202880;
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:50:02 -0700 (PDT)
Message-ID: <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:50:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger
 than the system
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-3-vdonnefort@google.com>
 <20240910124555.180428eb@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124555.180428eb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Yes I can take it through my tree.

> 
> -- Steve
> 
> On Tue, 10 Sep 2024 17:23:35 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Handle the case where the meta-page content is bigger than the system
>> page-size. This prepares the ground for extending features covered by
>> the meta-page.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend. This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer

thanks,
-- Shuah

