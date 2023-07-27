Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F65764491
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjG0DtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 23:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0DtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 23:49:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB422706;
        Wed, 26 Jul 2023 20:49:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C068A6015F;
        Thu, 27 Jul 2023 05:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690429742; bh=LvC5f0+bsJLrGcrnndWOgYlUfBmNxl0AAYWd0mu73eM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k0MpQF/1uLtggW8BRnM4mwuTQ+TyiDbsMxdJb2JvqGOstzElm/vKDVwZQOy8n03cb
         ByRl9Mht7CvypevdFbLyR2/OjvsHVhKbgXTNVhT+jOVMaIsk3iaCAjRGBn3dhAeaX7
         FT1ePyHZcBHvDAr3tPZI9JTvQ6kVPrQIZu3N0WvKCg0ku1x5/L2dRHHzYcoFe3Db4Z
         r1BV7G0m3Xd6P1q59Fj7/NWeZwV+w/vTWKO+T2G7vUsuGFfdgmvkEnKuNm4JT08+j/
         XjD3JPE5KJ6+aAM7jGDVtDkDhvefkp03b0H6Y9WDB7rGMg3otq+srSRg/+WZ/dqj1u
         /Rf4uKpphmqbw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GcMBv7-xvy9H; Thu, 27 Jul 2023 05:49:00 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id F11A360155;
        Thu, 27 Jul 2023 05:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690429740; bh=LvC5f0+bsJLrGcrnndWOgYlUfBmNxl0AAYWd0mu73eM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EAKXOB/KOvRg+Y30StkNSRpZo9dV02bbxOmhyfhnoh40zQ2I/h8OdZi1rehZE/em7
         ykg097w/EOpQtFesg1rH7G4XqTAWBtRmxUJIh7rVo4gETkUAvSEDgUUtWp89oIkXyp
         o0hietEUQ4M1/5dv1nPuh1GeR0uEN2jYPIP8WzfuNoozCPFkhof338ZgirqDQuXLAQ
         leoLczFZWQtHXRwvHrFoxlVAKkkUQz+CAEx2GJ2WjJphKAsCLIAaNEBgl7FXpUQ6GB
         4ddBlWSixnUP6+vOOazFM1Gm1KjbU7CtbpYiFa7Pt+rSZSvtVxDnLm+Zio5Cuc6DbU
         VJ4G/GNQQ1lew==
Message-ID: <55da6c17-9d65-0f29-2ce7-ccfb8339be14@alu.unizg.hr>
Date:   Thu, 27 Jul 2023 05:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder> <ZMFQZSI7InrLDG4m@shredder>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMFQZSI7InrLDG4m@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/26/23 18:57, Ido Schimmel wrote:
> On Wed, Jul 26, 2023 at 03:22:54PM +0300, Ido Schimmel wrote:
>> Regarding the MDB tests and tc_flower_l2_miss.sh, I suspect you might
>> have some daemon in user space that sends IGMP queries and therefore
>> messes with the tests. Please run the following commands in a separate
>> terminal before running tc_flower_l2_miss.sh:
> 
> Ignore that. I think it's a problem I already fixed in the past:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8bcfb4ae4d970b9a9724ddfbac26c387934e0e94
> 
> Ubuntu still uses an old version of libnet:
> https://launchpad.net/ubuntu/+source/libnet
> 
> Pushed the fixes for tc_flower_l2_miss.sh, bridge_mdb.sh and
> bridge_mdb_max.sh to the same branch.

OK, just to give you some feedback, I will fix these in the afternoon (Lord willing) after my day job
for the situation appeared on my home box.

I wish I could thank you properly for your work but I do not own the Linux nor am I a maintainer :-)

Kind regards,
Mirsad
