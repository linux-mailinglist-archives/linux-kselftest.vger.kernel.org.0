Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16559338A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiHOQva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiHOQv3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 12:51:29 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6415FF8;
        Mon, 15 Aug 2022 09:51:29 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M60fm5Nm6zDqqN;
        Mon, 15 Aug 2022 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660582288; bh=uWm5Eb+WIBElvupCbRA2LTbjzrzdUT0rQYgpokgr67w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5hed8Py+DKCC4aLw3EIbAYW9VyLooxo3kC4leERIIf+ewFZbqpeB/CP9Lq+XO/B4
         2fPkfVgJQTPPm9c2/svyIoHKPF5guMfL9TEIAWK50eqEzWYb7Td8tSPUnH4TjSlrk4
         HkbC0IhSZP7lWeXRwFlfzbpHtpFpgQii01WEIQck=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4M60fk3R6Mz9sLm;
        Mon, 15 Aug 2022 16:51:26 +0000 (UTC)
X-Riseup-User-ID: B787AFED1410C83EE15519B80EDE0A5E27441BAD857CF89BE76F8111F7FC81B1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M60ff6Fznz5vh4;
        Mon, 15 Aug 2022 16:51:22 +0000 (UTC)
Message-ID: <f0345419-ed15-047a-ca6b-d4c4bc542c7d@riseup.net>
Date:   Mon, 15 Aug 2022 13:51:18 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Documentation: KUnit: minor fixes
Content-Language: en-US
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, mairacanal@riseup.net, brendanhiggins@google.com,
        corbet@lwn.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
References: <20220813042055.136832-1-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220813042055.136832-1-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tales,

On 8/13/22 01:20, Tales Aparecida wrote:
> Hi,
> 
> This is a short series of minor fixes to the Kunit documentation,
> they probably can be squashed but I suppose it's easier
> to review them individually.
> 
> Thanks for any feedbacks,
> Tales
> 

Series is Reviewed-by: André Almeida <andrealmeid@igalia.com>
