Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E87473C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGDOL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGDOLp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 10:11:45 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E555F10C1;
        Tue,  4 Jul 2023 07:11:39 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3280333b3a.3;
        Tue, 04 Jul 2023 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479899; x=1691071899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVWqdQakMSUsv5oj8nSg9QczQrmrUO38b67MhpmWVYY=;
        b=ZH/KPRP50O9QKZQfFKaA+IfAWPHaD+Gxo1Eu3fP8ZxyDdYI3LJSQtB5pJ1LNZCP35q
         IiV8TxAZlRORnVGaqCJdzy5BFSME/+DZq9B+IS9yAxJQ4FU3c0sHLNVg4LaQttqWg5hd
         bM5LMjlOQJCGjfyUqstEXhs3Dd8wimOob7Q0h3RUn4qjwSxiYa/nobSPuoeZEPS9MS42
         srKFZ70VAwX7m2pI0PgphsbWrm6lh/UXvykFGzcIugoINW1nJ0OhoX+WdVsTs9eNV23E
         aJtRS4HrQ1C6JxK+hMqI3oWzf0iKWvVdvHE7pO3iCmyrKE+K3UE6Y5185bgItTX1QEDi
         4JGA==
X-Gm-Message-State: AC+VfDyguM2YZAAPdq0N9FgoO29YGFEhGKrGIR6kCa7gx3X6HXmDtixw
        qsAUMcwhyjDMUOAki/oH7fs=
X-Google-Smtp-Source: ACHHUZ4mKI72SACTkxfTB3tQ6Ji13XYniCvY2MHAxg/n5JeT4DfHtHYI7qLyK+rPyEqNoEPYk2/cWg==
X-Received: by 2002:a05:6a20:1456:b0:12c:d9cc:340e with SMTP id a22-20020a056a20145600b0012cd9cc340emr10681222pzi.5.1688479899229;
        Tue, 04 Jul 2023 07:11:39 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b00682a9325ffcsm1178509pff.5.2023.07.04.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:11:38 -0700 (PDT)
Message-ID: <739807cf-4551-4760-83e0-a94026b5c1b8@acm.org>
Date:   Tue, 4 Jul 2023 07:11:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <202307032309.v4K1IBoR-lkp@intel.com>
 <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/4/23 00:15, Marc Zyngier wrote:
> On 2023-07-03 16:11, kernel test robot wrote:
>> tree/branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> master
>> branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next
>> specific files for 20230703
>>
> 
> [...]
> 
>> Unverified Error/Warning (likely false positive, please contact us if
>> interested):
>>
>> arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
> 
> This *is* a false positive. The function is entered with a lock
> held, it will exit with the lock held as well. Inside the body
> of the function, we release and reacquire the lock.

Which tool reported this message? If this message was reported by 
sparse, has it been considered to add a __must_hold() annotation?

Thanks,

Bart.

