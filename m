Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AE5E6BEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiIVTlT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiIVTlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 15:41:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE70109767
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 12:41:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so9763268plz.7
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RYB6BGJvPvJGjlYGwc1124XJvSRMSlT6Ie4vSqCbQu8=;
        b=NXNO7E7T+Eyi3WutyeW9ldUi9IoU9NNBJMhaTF0dVVd0vk8qpu3V4Gk5o1s+REoJBv
         nMcvvb/RC6hRdTTXC9QTfK5ElqaoOjz91EccsETrFSLv1bmQsdZUJgaxtuXU3wRMTTWm
         zXcAb3TAUVeLw9qFSdkggVM7eoBeTibVNtY9ZSSGm3JgIosnbXWMF8r5eiHxPL7pcz8W
         FwDTQyPQvJWznbCcE0gTCQFaH9jYKKyQcuYpwD1OtQYoAJmuS/QdQHdbkTsLgpji8KVI
         qnGEAytavQzjikZ8+gL8CInhjTbDuHOJeDGw5aYG22h7QJX7FS2L1/FkW09VAtxFQ62l
         oHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RYB6BGJvPvJGjlYGwc1124XJvSRMSlT6Ie4vSqCbQu8=;
        b=WuofGhp1Oxjduoz9/7f0NTDh4cVUbcZ7/ct6EsbzANEvhW8tyZ77jh1bbGLBD5JxFY
         YB+nDuTkhX4OOJg7gwx8fmX+zbtHSCthHk2j4z1ZJYXgZLBX9kkAfrpOvC9g+MlditwH
         eBzsjnFI+va1fGdoAYpWAygNqy5YRUGP/0sONRlEye2zo7NFy8ueL7JzMZapCL4v7ZzO
         cvjFxTvF62H2c23hxqZq+NMK0F9RB/ur/cgHLYdXN2v2Yf05RvVpGVVv6vs8MoTtfxMu
         gYT1zIUSLdF3QKHSh3sbgoskYumPEdKoSH7HdZQHP0vObYwERILWWMiEpvlsDCEj+JEF
         zgAw==
X-Gm-Message-State: ACrzQf1G8bM10SN3RLhxT0iD8+LXhkXrphLZBz5XYWZkZ0e96aibt5yQ
        b39af39IVB2/9P8PUGtCynciiw==
X-Google-Smtp-Source: AMsMyM6XM0Ni4PvQQLJgk+M0su4MCNPn4YnN2e4DGaaMICBByIDPbg1bMi1yQ96V9IntdeRL18JRlA==
X-Received: by 2002:a17:902:b194:b0:176:d229:83bd with SMTP id s20-20020a170902b19400b00176d22983bdmr4740841plr.174.1663875675538;
        Thu, 22 Sep 2022 12:41:15 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b0017300ec80b0sm4618456plf.308.2022.09.22.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:41:15 -0700 (PDT)
Date:   Thu, 22 Sep 2022 19:41:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     cgel.zte@gmail.com, pbonzini@redhat.com, shuah@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmatlack@google.com, jmattson@google.com, peterx@redhat.com,
        oupton@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] KVM: selftests: remove redundant variable
 tsc_val
Message-ID: <Yyy6VxMhhua1mj7P@google.com>
References: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
 <b9044b55-1498-3309-4db5-70ca2c20b3f7@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9044b55-1498-3309-4db5-70ca2c20b3f7@linuxfoundation.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022, Shuah Khan wrote:
> On 8/31/22 08:31, cgel.zte@gmail.com wrote:
> > From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> > 
> > Return value directly from expression instead of
> > getting value from redundant variable tsc_val.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> > ---

...

> My understanding is that this patch isn't coming from individuals that work
> for ZTE. We won't be able to accept these patches. Refer to the following
> for reasons why we can't accept these patches.

Ouch.  Thanks much for the heads up!
