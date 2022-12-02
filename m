Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2604564010D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 08:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiLBHdv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 02:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLBHdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 02:33:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B70A65B7;
        Thu,  1 Dec 2022 23:33:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 430801FDA8;
        Fri,  2 Dec 2022 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669966428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7oXQABhKcba85k4/Fq5hfSey3hL6Wbzv/cZcgM/HRk=;
        b=ZkyWncoVrmJV2eGSfYKl74OCI3uNW31WwisASZWLwqUkku2zcWzlfvB51YwpYGvkIOPhHA
        dYbCBaBJAHsvhVcmPNMYvAO0JdlVnSIjGVyMjn7L2K/X2AaVyqBIEXPBDht+ivueXgXhZ+
        JiF3LZRbyvnMR/MabRTzRT91EJvaV6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669966428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7oXQABhKcba85k4/Fq5hfSey3hL6Wbzv/cZcgM/HRk=;
        b=0wgkpxqa+tnu+cRzWK9Ut2/RAhFVAiA7IrRcyrs3rJVs3dZ/vf7L7f1bu7U4+8WF/qrcTM
        633HVfB8a+WU8jDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A8492C141;
        Fri,  2 Dec 2022 07:33:48 +0000 (UTC)
Date:   Fri, 2 Dec 2022 08:33:50 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
In-Reply-To: <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
Message-ID: <alpine.LSU.2.21.2212020820390.5559@pobox.suse.cz>
References: <20220630141226.2802-1-mpdesouza@suse.com> <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org> <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz> <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org> <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com> <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 1 Dec 2022, Shuah Khan wrote:

> On 11/30/22 15:22, Joe Lawrence wrote:
> > On 7/15/22 10:45 AM, Petr Mladek wrote:
> >> On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
> >>> On 7/1/22 1:48 AM, Miroslav Benes wrote:
> >>>> On Thu, 30 Jun 2022, Shuah Khan wrote:
> >>>>>
> >>>>> Sorry Nack on this. Let's not add modules under selftests. Any usage of
> >>>>> module_init()
> >>>>> doesn't belong under selftests.
> >>>
> >>> Yes I did and after reviewing and thinking about it some more, I decided
> >>> this
> >>> is the right direction go down on.
> >>
> >> Do you have some particular reason why building modules in selftests
> >> directory might cause problems, please?
> >>
> 
> My reasons are that with this change module_init() propagates out of
> strictly kernel space and now is in selftests which are user-space.
> Any changes to this interface will be tied to user-space change.

I do not understand this (have not had a cup of tea yet).

module_init() is defined in include/linux/module.h. It is API. Every 
kernel module, in-tree or out-of-tree, uses it. There is only one usage of 
module_init() in Marcos's patch. In a kernel module, in tools/ 
subdirectory yes.

If there is a change to module_init, it might need editing all the call 
sites, yes. That is inherent.
 
> This is my main concern. That is reason why I still ask the question
> about why is it necessary to make this change other than self-contained
> sources?

I will quote myself from an earlier email in the thread which you have not 
replied to...

"
My main question is different though. As Marcos mentioned before, we would 
like to have our tests really flexible and a possibility to prepare and 
load different live patch modules based on a template is a part of it. 
What is your proposal regarding this? I can imagine having a template in 
lib/livepatch/ which would not be compilable and a script in 
tools/testing/selftests/livepatch/ would copy it many times, amend the 
copies (meaning parameters would be filled in with sed or the code would 
be changed), compile them and load them. But this sounds horrible to me, 
especially when compared to Marcos' approach in this patch set which is 
quite straightforward.
"

Thank you
Miroslav
