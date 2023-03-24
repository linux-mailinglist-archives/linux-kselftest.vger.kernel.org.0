Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458366C813D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCXPcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPcQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 11:32:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248121E1C6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 08:32:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e23-20020a25e717000000b00b66ab374ba1so2098285ybh.22
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679671934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wWj5gOBKK79F+U411pw+oLnnu4up+3JeOo4QflJRMs=;
        b=rfTPuN5gA17NBcmwJPvRfjQtsAwpqfGwbNMJ4apghPHh9Sg2/PNhVnwzTOSMs7XI+O
         yZNpqreHm1myeEi5LfJCi3HL+K5brljFzOQATNAvfU7E0TSRQPWDz66fULQF9Vy3rH0O
         RdhVDUVlUrg09IESx+uEy4FRMG/maagZASLl0Bs8lFbID+pnzhWbe4lb0AQbljzkwVW+
         gv6jrsdylvoXgQBjgDOSSmJtsMUlXxDoRX4E8bg2ffOru6PG25wSPjROowJVzI8io1cy
         onmoIVjHPQZeAOqzl2c92i/fMWO9QsajGd8vLJCHMRNDLyEYlnLjRXajBiC7n4hp4/VY
         dAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679671934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wWj5gOBKK79F+U411pw+oLnnu4up+3JeOo4QflJRMs=;
        b=K0KVOI2pFvGvOTTu2imIxH9jsV4TYmaEhY08MZ6L2selSeTSf/qPp6QR4HQbVgKqn3
         yEjXTGlX+iRLbTR4/2RYbINH5gdYrvoAIdSgGuzYESmBicj6JX1zeH/TX6vfDTxlF5ji
         9ARoun1Qz8DHKgRXVZBB8MJh5TVrmzMd4dRzTHRrpwha4VGQK6Mm8kZOMa6pAqAvcU/m
         VOOMjaqvSmBiiRJYtZi+s76hUJ4zgsdnUl/0IsWySIBN6fRuQ+9M6lst56indsjPjCDq
         hb/SOAUjsiZhg/nui/e2kHT0j/iAQnqXMdbWf6P3vx+11b4P7ESyvdg5D0bjJ/uGXN50
         0IjQ==
X-Gm-Message-State: AAQBX9cwMu3oD7qVdMXX/7vC2mOwuodaaQdROSuPxJERzWBn0JMehVfA
        QoeiBnlC2vPyEKcstoX1jJOxXncfok8=
X-Google-Smtp-Source: AKy350aR6TmyV8XNI1+jYOI4HteoseM0nrN8Xp9QMAlCHGUU2J5wvQmLvSBl9ObmAQouPC4xvepv2PnYDa4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:12d4:0:b0:b6e:d788:eba4 with SMTP id
 203-20020a2512d4000000b00b6ed788eba4mr1213205ybs.6.1679671934425; Fri, 24 Mar
 2023 08:32:14 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:32:12 -0700
In-Reply-To: <20230308110948.1820163-2-ryan.roberts@arm.com>
Mime-Version: 1.0
References: <20230308110948.1820163-1-ryan.roberts@arm.com> <20230308110948.1820163-2-ryan.roberts@arm.com>
Message-ID: <ZB3CfO3d8ULSFUwk@google.com>
Subject: Re: [PATCH v2 1/3] KVM: selftests: Fixup config fragment for access_tracking_perf_test
From:   Sean Christopherson <seanjc@google.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvmarm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023, Ryan Roberts wrote:
> access_tracking_perf_test requires CONFIG_IDLE_PAGE_TRACKING. However
> this is missing from the config fragment, so add it in so that this test
> is no longer skipped.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
