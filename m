Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397AB74266B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjF2M21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF2M1o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 08:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132B3ABB
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688041542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vo3tdImAdzQt1bSg9dpIf8+/mvpWr7Q4kdLME5s0JGA=;
        b=VjI9arHinLr6ZGgfpWJxiq3b2nHXf5EI8zeClPcyKC6kwGaJ7fxP8U3F7X9iaUGesvjyHR
        B5PmemK/ZuQiIw0JGZl3LiA/ojj4WkrRPQ+AwaOFGuGPqS/Okq7Ys3A4NpsIJxbgt/BZuD
        4uVjR7JDAWxlmSpQFRhOr5R6Wkf3acw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-djrDPkmHOHKgzNx0mhoZcw-1; Thu, 29 Jun 2023 08:25:37 -0400
X-MC-Unique: djrDPkmHOHKgzNx0mhoZcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7533680123E;
        Thu, 29 Jun 2023 12:25:36 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C496C09A07;
        Thu, 29 Jun 2023 12:25:35 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 0/4] selftests: openvswitch: add flow
 programming cases
References: <20230628162714.392047-1-aconole@redhat.com>
        <ZJyUoSaklfDodKim@corigine.com>
Date:   Thu, 29 Jun 2023 08:25:35 -0400
In-Reply-To: <ZJyUoSaklfDodKim@corigine.com> (Simon Horman's message of "Wed,
        28 Jun 2023 22:14:25 +0200")
Message-ID: <f7tjzvmmp4w.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Simon Horman <simon.horman@corigine.com> writes:

> On Wed, Jun 28, 2023 at 12:27:10PM -0400, Aaron Conole wrote:
>> The openvswitch selftests currently contain a few cases for managing the
>> datapath, which includes creating datapath instances, adding interfaces,
>> and doing some basic feature / upcall tests.  This is useful to validate
>> the control path.
>> 
>> Add the ability to program some of the more common flows with actions. This
>> can be improved overtime to include regression testing, etc.
>
> Hi Aaron,
>
> sorry but:
>
> [text from Jakub]
>
> ## Form letter - net-next-closed
>
> The merge window for v6.5 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after July 10th.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

Thanks Simon.  I skipped looking at the ML this time and used the site
setup for random German tourists:
http://vger.kernel.org/~davem/net-next.html

I guess I'll stop using it and just check the ML as normal :)  Sorry for
the noise.

