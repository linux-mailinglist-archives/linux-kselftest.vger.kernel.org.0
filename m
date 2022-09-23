Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F755E741F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiIWG3q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 02:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiIWG3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 02:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75451280F9;
        Thu, 22 Sep 2022 23:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F346612F0;
        Fri, 23 Sep 2022 06:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BEBC433D6;
        Fri, 23 Sep 2022 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663914469;
        bh=TdJrTT8FDQYJZs18nJ4Mh6O+0KQmY7Nw9igqLQnPdHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dj90cAbpLQwo0BQCpgx5QtvWWoCxxsRGMyxHbRtcniQDPc/eSESsBaV03vBz2W4SZ
         PU3EViDNQ13xk1gDgM4A8zZApDXj/zXhXQXb8j68AneZ2cJSJCbY4g4Xn+V9Z1qidD
         Vk6LoRQ41AIDMOMJYb7vvZCJbIeR1Xn36Ahkns28=
Date:   Fri, 23 Sep 2022 08:28:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     cgel.zte@gmail.com, pbonzini@redhat.com, shuah@kernel.org,
        seanjc@google.com, dmatlack@google.com, jmattson@google.com,
        peterx@redhat.com, oupton@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] KVM: selftests: remove redundant variable
 tsc_val
Message-ID: <Yy1SBF2c4oH84sEl@kroah.com>
References: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
 <b9044b55-1498-3309-4db5-70ca2c20b3f7@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9044b55-1498-3309-4db5-70ca2c20b3f7@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 12:45:22PM -0600, Shuah Khan wrote:
> On 8/31/22 08:31, cgel.zte@gmail.com wrote:
> > From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> > 
> > Return value directly from expression instead of
> > getting value from redundant variable tsc_val.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> > ---
> >   tools/testing/selftests/kvm/include/x86_64/processor.h | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > index 0cbc71b7af50..75920678f34d 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > @@ -237,7 +237,6 @@ static inline uint64_t get_desc64_base(const struct desc64 *desc)
> >   static inline uint64_t rdtsc(void)
> >   {
> >   	uint32_t eax, edx;
> > -	uint64_t tsc_val;
> >   	/*
> >   	 * The lfence is to wait (on Intel CPUs) until all previous
> >   	 * instructions have been executed. If software requires RDTSC to be
> > @@ -245,8 +244,8 @@ static inline uint64_t rdtsc(void)
> >   	 * execute LFENCE immediately after RDTSC
> >   	 */
> >   	__asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
> > -	tsc_val = ((uint64_t)edx) << 32 | eax;
> > -	return tsc_val;
> > +
> > +	return ((uint64_t)edx) << 32 | eax;
> >   }
> >   static inline uint64_t rdtscp(uint32_t *aux)
> 
> My understanding is that this patch isn't coming from individuals that work
> for ZTE. We won't be able to accept these patches. Refer to the following
> for reasons why we can't accept these patches.
> 
> https://patchwork.kernel.org/project/linux-kselftest/patch/20220920063202.215088-1-ye.xingchen@zte.com.cn/

Thanks for catching this.

Also this address has now been banned from the kernel mailing lists, so
watch out for patches sent to maintainers that do not show up on
lore.kernel.org.

thanks,

greg k-h
