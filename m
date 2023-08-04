Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF346770B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 23:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHDV7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 17:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHDV7s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 17:59:48 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 14:59:44 PDT
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAB180;
        Fri,  4 Aug 2023 14:59:44 -0700 (PDT)
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 374LdqY3031774;
        Fri, 4 Aug 2023 23:39:58 +0200
Received: from [192.168.1.55] (host-79-18-185-225.retail.telecomitalia.it [79.18.185.225])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 2F7C01209D4;
        Fri,  4 Aug 2023 23:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1691185189; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2eY65w4QX2NFbKU1+DDTyYdgcmreNvLmXgo7ENzCQY=;
        b=z57vFvjdKrtJ+iilaAJJLfVIouzA+c8OFSmCnw4GuawqK8M0dmlNn0k/Fy2e7u96x1ehCF
        DIOPPKSst3eLXXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1691185189; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2eY65w4QX2NFbKU1+DDTyYdgcmreNvLmXgo7ENzCQY=;
        b=Ox71sguE0YicW+Ke/W0Pw44zeXJ7qgQKqTLeTdr1t1m7lMROPyrvdm7pHujGvWzolsGQbM
        r/YxW2A49ma1vaWo3TwleiR8Xnx+Hxpd4zY6dm7cLWU9sKUx437ovbKOK9qop6dUaNIf/a
        Fev0p2Q8qan4LabWBH7lARiDS7KOeTqSa5ShLVlI8Hpc4jc35iWrjLSKgQ7R00B08OkOHy
        GTlBxLksejW4WEFrZQoe1cjo3dfvCe4YplSnn1CSddwGDw69bh+bavF2gz0GTuVk8tA9eM
        E4g4qEEJSMVHKAPJMO5Pvcix+YdUtTXjTDULLD/YGm5BgKJCwxu9Ohp0uM9n8g==
Message-ID: <f778eef0-a035-0a29-3108-0f6f53a475ed@uniroma2.it>
Date:   Fri, 4 Aug 2023 23:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [net-next 2/2] selftests: seg6: add selftest for NEXT-C-SID
 flavor in SRv6 End.X behavior
To:     Paolo Abeni <pabeni@redhat.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
 <20230731175117.17376-3-andrea.mayer@uniroma2.it>
 <9916825da00d375a33abdcb0aa773c5520a307e1.camel@redhat.com>
From:   Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
In-Reply-To: <9916825da00d375a33abdcb0aa773c5520a307e1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 230804-6, 4/8/2023), Outbound message
X-Antivirus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

please see my answer below, thanks.

Il 03/08/2023 10:07, Paolo Abeni ha scritto:
> On Mon, 2023-07-31 at 19:51 +0200, Andrea Mayer wrote:
>> From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
>>
>> This selftest is designed for testing the support of NEXT-C-SID flavor
>> for SRv6 End.X behavior. It instantiates a virtual network composed of
>> several nodes: hosts and SRv6 routers. Each node is realized using a
>> network namespace that is properly interconnected to others through veth
>> pairs, according to the topology depicted in the selftest script file.
>> The test considers SRv6 routers implementing IPv4/IPv6 L3 VPNs leveraged
>> by hosts for communicating with each other. Such routers i) apply
>> different SRv6 Policies to the traffic received from connected hosts,
>> considering the IPv4 or IPv6 protocols; ii) use the NEXT-C-SID
>> compression mechanism for encoding several SRv6 segments within a single
>> 128-bit SID address, referred to as a Compressed SID (C-SID) container.
>>
>> The NEXT-C-SID is provided as a "flavor" of the SRv6 End.X behavior,
>> enabling it to properly process the C-SID containers. The correct
>> execution of the enabled NEXT-C-SID SRv6 End.X behavior is verified
>> through reachability tests carried out between hosts belonging to the
>> same VPN.
>>
>> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
>> Signed-off-by: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
> 
> The patches LGTM, but there is a minor issues WRT the tag area. Since
> this patch contains a
> 
> From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
> 
> tag, Paolo's sob should come first.
> 
> According to the the newly created shell script comments, it looks like
> the patch as been co developed by both Paolo abd Andrea.
> 
> In that case the correct tag sequence would be:
> 
> SoB Paolo
> Co-devel Andrea
> SoB Andrea
> 
> Since the above is relevant for correct patch authorship attribution I
> suggest to address that in a new revision.

We will follow your suggestions and we resubmit the v2 patch with
the tags in the correct order.

> 
> BTW, I a really appreciate the descriptive-but-not-too-verbose commit
> message!
> 
> Thanks,
> 
> Paolo
> 

Ciao,
Paolo
