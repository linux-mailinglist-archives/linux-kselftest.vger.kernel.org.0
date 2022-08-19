Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28359A882
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiHSWSR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiHSWSP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 18:18:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F4D64
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g18so5870335pju.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=BcAPABzciTIGP2cxF54N2Wsd/iSJnRwhaMTJUEPlID3X+lEPUS9PKxCYhEulFZwRxd
         06bqrTdWnqjtnqc2C3v4TI8GRA6eiJXScnwQfLinTWZ/GYZMRuQkN3HbWHc1PSDNRaEY
         Xl4RNP3A6PtVIwmuNLThV2GWpVrvVfgQSzyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=r+cCMT58pYHKtEwlcJSRL8VNEfa9oIZs3vISfoDn2kc=;
        b=eySUDyUoD/VKNWJ4jWJrMqfgn0YhO18r6/7QwRMppDS85NqrALg6FFne7SKMRRDfrE
         P+UimM6xAC0az0GtoLTgH//CuEB+LPdQX0e97ukueQBbfwWtZC+8JqI7cx+UwKGYag0N
         5mIU1FRC8bAqTSJf5bkS144PcPRx9BLnXYKxyOg/Rm5qUDPs6Ql3/eO0PjWZNZ78U3Se
         s+My5FepFvMhW1m8mH1T2XwJVx7tZl/NN6gDQEvOqQDx1Oz0EPyUwBQhuZbEYv1/H76W
         nYJJs0EAx9J7cVqvQhaFm+NbQa8pKnpbU9CQqkREQcmaao4Hli+48U/E3GI5q1LQe2gQ
         g0sg==
X-Gm-Message-State: ACgBeo0bk1QsnyimemUM35jCw8AkGAMFPpOgPu8M4S8sBqCor5CdyWVb
        oMCU9fkFIQRuGWaNWdXIJiWL8w==
X-Google-Smtp-Source: AA6agR5RK5bWwK14DmSWfIsVl2lWE7zgftE7SAP1zrNok3zDiq4QmjJez0ZgiEkrRJEXvaPKAwRg5Q==
X-Received: by 2002:a17:90a:8911:b0:1fa:c8f7:1450 with SMTP id u17-20020a17090a891100b001fac8f71450mr10531200pjn.123.1660947491479;
        Fri, 19 Aug 2022 15:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm3603350pjh.50.2022.08.19.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:18:10 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:18:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, davidgow@google.com,
        corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
Message-ID: <202208191518.980071F7@keescook>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819053234.241501-8-tales.aparecida@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 19, 2022 at 02:32:33AM -0300, Tales Aparecida wrote:
> Replace URL with an updated path to the full Documentation page
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
