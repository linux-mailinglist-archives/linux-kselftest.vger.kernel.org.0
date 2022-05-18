Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0C52C634
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 00:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiERWXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiERWXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 18:23:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D61F7E1A
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 15:23:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i15so2482726ilk.5
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w5RfX8/Rv7yQPUAnH5qBKrcDO1Mm9mdpkNqUpF+8goU=;
        b=Vp6aagYWx+xbz9SJTBgZR0G9TrlTmXBPwdVDNVlS/jP6tMxTDONTEtXxFFMACKHQ92
         e4DhrJbFSk/A8EVBl+jyJZHPz88EhUnxgn4YhPZ/R8KR3kwLnl9YHshvCJfNKCuBW6YA
         vVVxZNiKJrNAjD7ii58tkXT+SNlhWxQMXwKtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w5RfX8/Rv7yQPUAnH5qBKrcDO1Mm9mdpkNqUpF+8goU=;
        b=iLL102ALwV7W7sGEAHHXnQNC9292j6DgoNi7+GJRKIeV7wJBIdY7TS+4Svubn4WJIN
         Bkf4u5DX6NFaOXnnN1xp6o2E9aKBmSqu5QUJaZsZmE6I1Q2RShUoClvL4J0CeDnWmcPI
         50rJ6KMabzxxPlEidZeGFKC7S4jZLN8OlmJnWmZHDsNgMMxUjdxQL0uz5XITm2yWjwsS
         WanAdpgLNFHyqL+LGnbuZryv7jRSN4oNu+qfu1PX7/ocF4cp+9MgNotwYG6x+EiIss7Q
         rNXdYtyc8M7nblQ9zL9diDaBgkSkIyF9gwfstdc9SaiUhs53yV+puT/xXKmqLgm0bWgZ
         VJcg==
X-Gm-Message-State: AOAM532Fo6xpKqd4lkno7PqY1kJq+BulBfCDu16cWMxhBDtpWgb8fJ5Z
        hQnX7WQLIpTfQyZ0btJ6vS1/iw==
X-Google-Smtp-Source: ABdhPJzKCuF7JRxOdyp5CvlBmcPHkPFHNXjwd+grkUrJqygaKaMSoob85tO7D69QkE403CTm54Cqqg==
X-Received: by 2002:a05:6e02:1c4e:b0:2d1:a8d:e94d with SMTP id d14-20020a056e021c4e00b002d10a8de94dmr1020917ilg.194.1652912627881;
        Wed, 18 May 2022 15:23:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a05663802a500b0032e15dfbf13sm201221jaq.113.2022.05.18.15.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:23:47 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] selftests: vm: add process_mrelease tests
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220518204316.13131-1-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b05f63a-c1b7-1b36-4305-8ee9e34f0e04@linuxfoundation.org>
Date:   Wed, 18 May 2022 16:23:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220518204316.13131-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/22 2:43 PM, Suren Baghdasaryan wrote:
> Introduce process_mrelease syscall sanity tests which include tests
> which expect to fail:
> - process_mrelease with invalid pidfd and flags inputs
> - process_mrelease on a live process with no pending signals
> and valid process_mrelease usage which is expected to succeed.
> Because process_mrelease has to be used against a process with a pending
> SIGKILL, it's possible that the process exits before process_mrelease
> gets called. In such cases we retry the test with a victim that allocates
> twice more memory up to 1GB. This would require the victim process to
> spend more time during exit and process_mrelease has a better chance of
> catching the process before it exits and succeeding.
> 
> On success the test reports the amount of memory the child had to
> allocate for reaping to succeed. Sample output:
> 
> $ mrelease_test
> Success reaping a child with 1MB of memory allocations
> 
> On failure the test reports the failure. Sample outputs:
> 
> $ mrelease_test
> All process_mrelease attempts failed!
> 
> $ mrelease_test
> process_mrelease: Invalid argument
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Changes in v3:
> - Applied on git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-stable,
> per Andrew
> - Fixed formatting for sample outputs in the description, per Shuah
> - Removed pidfd_open, process_mrelease, write_fault_pages functions, per Shuah
> - Moved child main routine into its own function, per Shuah
> - Followed tools/testing/selftests/pidfd/pidfd.h as a model to deal with
> undefined syscall numbers, per Shuah
> 

Looks good to me Suren. Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

