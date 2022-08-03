Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF8589226
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiHCSVV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHCSVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 14:21:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA11583A
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 11:21:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm17so11726307pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nsqh0CIbwvJ/pgXSEB6oG4Xy1/woHrUtn/IceLa3N0o=;
        b=Mz7gnu/VZCsDdtuvgzoWWrZTyBOivrPLG1HNJ+EOLit/5tJ/Xiahx1DIxiLjo95pbf
         RexuAaGX8IeAIu9IinuPXQdSjBPX2mDsVVYCCThWPPEEPOiwxkTnRNC0l7Yk6GMz11jD
         NWzbZn4FYbhn5O4VetrsjMKxxVhWt8sXSictshJmlEKoCWRm7sVWeSriiEK7Y4rlkn+5
         /+B79Z4ExSGtJBY+K0J6QeqD+B6MmslHI4xNwWaawrssbEY+JiPLvTzwuOFgt13/Wqh8
         yEBx94gSJC/S1W0syyNwJMK1HPX9xphMR3G7vdr4r7kCFAP17Mq0hZGh2SW3KDjMPDrs
         tUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nsqh0CIbwvJ/pgXSEB6oG4Xy1/woHrUtn/IceLa3N0o=;
        b=hMMhA1F/7w6Tq7+H9wymo0yLFEAbH4+XCM0S87qhMnwuuE5Om5FxxgC3U1X65dL41o
         y25vY5ADXF24NXtB62mairW+NCuBXdJR6PMEobmmIUcWUptKwdxVr++/iBpZcNKdVhtn
         OCNbCglHzAquEf3sI2S1A7nVvDMKD6rPTTKB0hbBM+4PJ/yXzngsei0WwAHnyV8rGxAN
         sIUP21HjKQ7lsKixsZBqPfGbztGSWTGxDOejJJFbQO+fQO108jjvX5/LReCsTIOCzyIW
         Q9B5jxkO26DfaANue1MuBJL9tUKWA7UrvRlu5Yi7dZDJ6ZzLETCkeNRohDlP0wxSfXH8
         aFsQ==
X-Gm-Message-State: ACgBeo22bv9RymbbF4mAZaZbabdXnNWJG2Oq/T/yfyk+zLTrCZWx5doC
        53+Z4QB2A+KlEeuIQ7EL6rvt/sLe8woEMA==
X-Google-Smtp-Source: AA6agR4YSibnTcRYrFz2ZoDNodfpJuyX4JLT+iJz7Yvex1VpFcHWlYEO9XxUz12BN03Te3VybjNJjw==
X-Received: by 2002:a17:902:f688:b0:16f:28:ea27 with SMTP id l8-20020a170902f68800b0016f0028ea27mr10761229plg.151.1659550879177;
        Wed, 03 Aug 2022 11:21:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b0016bfbd99f64sm2299900plh.118.2022.08.03.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:21:18 -0700 (PDT)
Date:   Wed, 3 Aug 2022 18:21:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use ASM_TRY
 for the UD_VECTOR cases
Message-ID: <Yuq8mumnrww9rlnz@google.com>
References: <Yum2LpZS9vtCaCBm@google.com>
 <20220803172508.1215-1-mhal@rbox.co>
 <20220803172508.1215-2-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803172508.1215-2-mhal@rbox.co>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 03, 2022, Michal Luczaj wrote:
> For #UD handling use ASM_TRY() instead of handle_exception().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> I've noticed test_illegal_movbe() does not execute with KVM_FEP.
> Just making sure: is it intentional?

It's intentional.  FEP isn't needed because KVM emulates MOVBE on #UD when it's
not supported by the host, e.g. to allow migrating to an older host.

	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
