Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8896477DC57
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjHPIeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbjHPIdk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 04:33:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE22706;
        Wed, 16 Aug 2023 01:33:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565ea1088fbso826904a12.2;
        Wed, 16 Aug 2023 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692174798; x=1692779598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+0PVxwBEghPGirS4xN4p99bdGIsDm3H7t/XiQTGcd4=;
        b=WYeG8mfH6+weMiZVg8Zg2vFnRK/f2tH8MEZf5fvQNfGNxyrHCW7+TTjid+PyIv7FNF
         D9MjRR7O1KIHXaW5IvGY0is0HqsL4oo4uo9cysB5EFYzt2yzKfP3lPfYtppsb32gKpVJ
         JFJAaER3v1/jRfSd40dyOnuLGChsqsr66Ol7d4+hg2nMP+JrvQ/jZmXmtQvm4KqeEfXS
         J49+VDvk1IV8QkzbQpGF7yAuuHspb3DGwuF51X5a0q5oQqlrexkFVRtygzfqb427EYlx
         oJf9hmedQP8EJ2h2ZckcZ21mBVp6i7bGuSnm3sv8YHSFoQ5B8wLjdvVPLducll6Sq80E
         TzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692174798; x=1692779598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+0PVxwBEghPGirS4xN4p99bdGIsDm3H7t/XiQTGcd4=;
        b=deXCScNrr0ugZwBJnMZoLgEAIDRDY9rAG9zpVu//j2/cgoluba3jPpJSfp/cLOOqEe
         Na8f6cKpc352DwKOvmPBGpDSKoaoKApcZ+kCSf0Q5lxpewSGO9PDC4xsHCFuk0I9e8G/
         Dxfy7FePqgzVywJgxbOzm4OHB0co7n3qzk2r2QxEEa+cUByQoo5w8MWgt+vGw9SlXavr
         MmEPO9C2KOTcWUypnQlWkJAOeVR/yb1C5scHrYzyWVHyk+ZWipNT8CgHp4Xc65p7UA9E
         KFnf4PqttZwMQr2tCEeUguRjsfrTVVnZShz2NXLH+QtHrzfW2z0pMCZcKX8kJRMvXAzP
         k8PA==
X-Gm-Message-State: AOJu0YyP27clhZ4iODN1bFYzLjBqTJWxw1Y/z55dURNY9HD1TcdfSrTs
        PFu0GlbRuyUQEseiN0syBwU=
X-Google-Smtp-Source: AGHT+IG/mvk0WcBKHkr7hsPmymVoMRxdsNgw/GDpQvu7VUbLkMbGMXNThaJL5KU6P5b981UyBuoEFA==
X-Received: by 2002:a05:6a20:5485:b0:140:a6ec:de6b with SMTP id i5-20020a056a20548500b00140a6ecde6bmr2024965pzk.51.1692174798235;
        Wed, 16 Aug 2023 01:33:18 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b00679b7d2bd57sm10596471pfi.192.2023.08.16.01.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:33:16 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:33:11 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     shaozhengchao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete
 action of device link1_1
Message-ID: <ZNyJx1HtXaUzOkNA@Laptop-X1>
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
 <ZNxorHjkyjktoj9m@Laptop-X1>
 <a363d616-eadb-2136-a445-f946c24cd66d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a363d616-eadb-2136-a445-f946c24cd66d@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 03:55:30PM +0800, shaozhengchao wrote:
> 
> 
> On 2023/8/16 14:11, Hangbin Liu wrote:
> > On Sat, Aug 12, 2023 at 04:40:36PM +0800, Zhengchao Shao wrote:
> > > When run command "ip netns delete client", device link1_1 has been
> > > deleted. So, it is no need to delete link1_1 again. Remove it.
> > 
> Hi Hangbin:
> > What if the test exit because the cmd execute failed before setting
> > link1_1 to netns client?
> > 
> > Thanks
> > Hangbin
> > > 
> 	Your consideration is indeed possible.
> "ip link del link1_1 >/dev/null 2>&1" maybe looks better?

I have not objects to this. On the other side, this only omit the error
message. It doesn't fix anything.

Thanks
Hangbin
