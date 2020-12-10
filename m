Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC722D5183
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 04:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgLJDjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 22:39:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45015 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgLJDjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 22:39:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id f9so2736386pfc.11;
        Wed, 09 Dec 2020 19:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vl3B7XtbEhQjt2nq8MXPBFdyJIVZUFP3ezbjFEmRzg8=;
        b=ecgffhcT4fpoyypTmpgIoOigMAIhaRhOriXOhdIrvGb8Mw5BVHA5CyMSA1evXFHITX
         OqvmdPUKlfx+RoYkE4GPvc8N/LOWhspeAfhsJCsvlykZht/qrivh/L6DSul6txih2nf1
         LBnOcv/fGgWpBUb7OEEX83z27uoUaxymB5ZtfrRaGIph1CYFU3b4M5VifhYoXb83yDJO
         q2u68quyjHa/0NcFFeFaSP75Ppu+BJjJsc2/HPACmOGf8U0QgvRCb5Xu/+1CD2EFNwC8
         3Qcvx5MnDc5sGP0hT2KVhxcFY94o9M0Oh271O3ny84gtlU/StPZ38WdQAFQQ6yDayyMs
         Da0g==
X-Gm-Message-State: AOAM5330b1FF6d+5nY9AcaXe39uzye+JAnJ88zIgoBb1zOLm/atWedVh
        Fy8+hCcwCmVfNSpylPYp/FQ=
X-Google-Smtp-Source: ABdhPJyk5LMpvJBOnoJv/cjrpAyasLKu4LBxr7jKQq4OCERkzn7Dwo1S3bQcoGiBB3763Qi0ahgwYw==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr4835088pgj.254.1607571536653;
        Wed, 09 Dec 2020 19:38:56 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b4sm3743505pju.33.2020.12.09.19.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:38:55 -0800 (PST)
Subject: Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies
 BIOs to userspace
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     snitzer@redhat.com, corbet@lwn.net, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        Josef Bacik <josef@toxicpanda.com>,
        Mike Christie <michael.christie@oracle.com>
References: <mhng-97fc5874-29d0-4d9e-8c92-d3704a482f28@palmerdabbelt-glaptop1>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6fb5be2d-c6ca-c21b-dddf-9b314973dcfe@acm.org>
Date:   Wed, 9 Dec 2020 19:38:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <mhng-97fc5874-29d0-4d9e-8c92-d3704a482f28@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/20 10:55 AM, Palmer Dabbelt wrote:
> All in all, I've found it a bit hard to figure out what sort of interest
> people
> have in dm-user: when I bring this up I seem to run into people who've done
> similar things before and are vaguely interested, but certainly nobody is
> chomping at the bit.  I'm sending it out in this early state to try and
> figure
> out if it's interesting enough to keep going.

Cc-ing Josef and Mike since their nbd contributions make me wonder
whether this new driver could be useful to their use cases?

Thanks,

Bart.
