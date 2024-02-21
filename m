Return-Path: <linux-kselftest+bounces-5097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506D85CCAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE082813BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0287EC;
	Wed, 21 Feb 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dCEcZzUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70865382
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474971; cv=none; b=HYz5OsaOlZJOSY8PACConNv17TpwgbLUPar0ppU+HngrbvYaKLeph1vVLpDTaH/gI6Z8gd0kZGwcCdnHWdC1zhQTxoMwPlIZOu/l/QDimW1aV//R32LXZdgaH5V29TIPznPDFwVxt9tMfF6xznx5mi80G47GUBJ4KGNwOBdqoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474971; c=relaxed/simple;
	bh=8WZKHSERv1Qml7vaoGY8qsCxDz2HE26cW/okoCj1S1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkKT7GLen1Q+FzF46XEYuw2+Ox0pfbpIxxdU+ZKj1kuppp0eAxvxY6F15rLFlk7gI312U9W0/vsla66vmITOmw3qcONHWq2Uta45EDFtWyhdO7XMG5Oaqs8bMuLrGDuWWVGWlmVUG9W6y9qiLNRG6hnbJaAb+o5QDVJ644khpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dCEcZzUV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42db60ebcd7so678631cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708474968; x=1709079768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNzWCTUy9JFU/dlrovuUssQto5vHi7/OuWTxzbCEBhA=;
        b=dCEcZzUVCwpF25X9tqVGSvgcNLTGzT/X5FJ/nYzFP4eFvFXvni5PxD4swkZnST6tbZ
         +NzMZ7b17zLKU3iRqCuNOc/mIJDttZjDgTNendqKM36PD/pGFSmHJak3fUBne2Gr2bn1
         pL6drN9Q0QVz9M7Cwl5szxC0ZPUEUpJ02xxjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474968; x=1709079768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNzWCTUy9JFU/dlrovuUssQto5vHi7/OuWTxzbCEBhA=;
        b=YcEDrW2EpPixZBGJ+wEVAl8PCO01IgRM4XyE1sMUe+NolPWRjmrKjtV0iqFrX6Ukv3
         s3egQtF5hWOv4wSSJRJ0TRrhg/98A5EhD+K9b5dhqH6glgaJ2PdXCwqTHVRPsp1MIVoR
         Kfj4kWmqy2MU1DBXfKOa6quZLrrZfy69YDPDDXa/fIQQRr7p0WZ8W6Ur6YUXqt7Qes5t
         NGQpkf1MiVeEwIfaA05vGBxQINRgjN4l5KX1oOVehroGfwai3mdJMCO9mvMUx+BQsdzH
         1UD5SDUbN57JbU3/I3PUaIuLiUB7y5UY5jjHcWWfIjmSs6X8207YiURkCXAjK3oeVtZs
         mFGA==
X-Forwarded-Encrypted: i=1; AJvYcCWcHo1WzBilIIT2itPDmHsPgvW5AtH91/sDc4WC5yHqNRmX0ipOz/O3gAJcgOe5XlWiJ1g8FkdXX3zKpb3EeHL4JXww+souXLIrx86H7REk
X-Gm-Message-State: AOJu0YxCYjIUfoZVHB+2HOYr0zmwC7Bb8h7GD4o7IciYFS0l7vHmhNF8
	HoKQKFxVQEGweB+BZSSqblFddmAmv7L37OAoFGzrs3x/vaZTF/UNmetIDkIDqws=
X-Google-Smtp-Source: AGHT+IGkEKD5s4h+KVSBolVi/KlyQ6g705fjRLMKfE75hTkTjwe3yoI9olwSKK13//mX6vNwgW7HbQ==
X-Received: by 2002:ac8:59c6:0:b0:42e:24c4:ca0c with SMTP id f6-20020ac859c6000000b0042e24c4ca0cmr4792013qtf.60.1708474968337;
        Tue, 20 Feb 2024 16:22:48 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id fu19-20020a05622a5d9300b0042e1498d645sm2061807qtb.92.2024.02.20.16.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:22:47 -0800 (PST)
Message-ID: <55e64c9c-8c12-4d1a-b508-3165f7078b8b@joelfernandes.org>
Date: Tue, 20 Feb 2024 19:22:43 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] selftests/sched: Migrate cs_prctl_test to
 kselfttest
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>,
 Chris Hyser <chris.hyser@oracle.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Phil Auld <pauld@redhat.com>,
 linux-kselftest@vger.kernel.org
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-9-joel@joelfernandes.org>
 <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
 <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/2024 7:03 PM, Shuah Khan wrote:
> On 2/16/24 12:18, Chris Hyser wrote:
>> On 2/16/24 13:31, Joel Fernandes (Google) wrote:
>>
>>> This test begs to be a kselftest, is in the kselftest hierarchy and does
>>> not even use a single kselftest API. Convert it.
>>>
>>> It simplifies some of the code and the output also looks much nicer now:
>>>
>>>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>>
> 
> Assuming this is going through sched tree,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I think Peter is out so it may take a while going through the sched
tree. This individual patch is independent as such and could go through the
kselftest tree. However, I am totally Ok with either option.

Also, thanks to you and Chris for the tags and I will add them for future
submissions.

 - Joel

