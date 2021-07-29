Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05693DABC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhG2TWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 15:22:13 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:40525 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhG2TWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 15:22:12 -0400
Received: by mail-pl1-f169.google.com with SMTP id c16so8137438plh.7;
        Thu, 29 Jul 2021 12:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZ0lluIYyP/MXBJ+IRMNV99KvccYsXlf1DWrrHOIiss=;
        b=qGXaMdZfgS6tiOQ8TxVfEAwpfz3kclTp3mkXqPwkalxLDoLeJpl67Z1wrvPHeH1jgz
         6KcJXRT4i/Svt3Hlin34VhSO2wkI7VjXki+ymL2sQ5RboqgPBBH5mdRtB8DmWJGs+k8O
         k4BlAfm2/TXE/n7KK3L5Elj3KL5H8/iknqqnX8kqk5PxnA90DthovhESNMz3EYeO8ztW
         FfAE79EHxNuzUMlYa8uz27Occ60G16WWmZEiM1lkL/new0Wdj06d+ue4FOrFAe4DZ6Lb
         4P5jY/zV+4w5MRr9D0j99CUZr3XIJHehJ/i9b3dWsL3I1ycWr54G/SMPzf0H1eSJPXgu
         HFXQ==
X-Gm-Message-State: AOAM531Nta70X03LGcGAWTSOJsbsInYfNbjWkGRlJqhXiPlHOiscgXOX
        Ahw+XGjgKSMXernEccON6VE=
X-Google-Smtp-Source: ABdhPJx88t+rVzQn63rRH3qW13fakl9IITl46nPf4CI42kgu+DExhaAWnap/3sz0Aa8hQg+jiGdSrg==
X-Received: by 2002:a17:90a:bd98:: with SMTP id z24mr16474852pjr.99.1627586528943;
        Thu, 29 Jul 2021 12:22:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:684a:6173:abee:6f13])
        by smtp.gmail.com with ESMTPSA id s193sm4594659pfc.183.2021.07.29.12.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:22:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org> <YQJCyigNroTl8J/l@kroah.com>
 <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
 <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
 <bbe15cf5-229c-13b2-126e-e773c0ba18c2@acm.org>
 <81edb935-aabd-bd05-c3d1-260903b3c726@linuxfoundation.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5f356522-e61b-9605-5f82-e805efcaef3d@acm.org>
Date:   Thu, 29 Jul 2021 12:22:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <81edb935-aabd-bd05-c3d1-260903b3c726@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/21 11:42 AM, Shuah Khan wrote:
> Please take a look at Documentation/process/submitting-patches.rst
> for information on commit logs.

As one can see below, I'm already familiar with the kernel development 
process:

$ git log --author="Bart Van Assche" | grep -c ^commit
1664

Bart.
