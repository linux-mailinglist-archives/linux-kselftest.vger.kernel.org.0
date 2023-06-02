Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43601720121
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjFBMIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjFBMI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 08:08:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA8E7
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 05:08:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so20089535e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685707704; x=1688299704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N5RSBDUYVnk68nNFO5iJo36EpLGHeNx7EXSoald+6Y=;
        b=vbCorPrw3tzdPss9fLKN2Jev52SLfxSgOQqoKYqSY65ZLrLB+P74BJBRbJMFFlcFg2
         V7Ot2gZjxhSVBPFfbnvwW9yQnphdHhOVXVBSwm4xRuxJ7ex+cLBItdHMh0IW9kYNykOa
         7ioPtcQlOz5kRi11B/L0Pqn/A4DqxsPhLJciZSe5it+Ilkag+UN92q1nxXIWDU/bW0qK
         6n+AgA2OZjG9C+NW4fCSkwSci3fkVM85PC1Jj5pey0miF/c1R/uevQGKz7/OoRj2qh4D
         /Wvth9lpOh+tzo6e1tyb8kTh0oojqqD8BaMgr10akG2ABdWDuoArukXsPjYCzyfN3h4D
         0dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707704; x=1688299704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N5RSBDUYVnk68nNFO5iJo36EpLGHeNx7EXSoald+6Y=;
        b=iXeLmgkTp/hSjmCKDTIelpUxOX3ujupdMD/sUec5Nck3zxU1jcYp3icuOlmv5TDAkM
         7/kdr4TE/p3kXu/BwR/M85XuP4QJ4MHP7YywezIYPZnK/mCnzjCUeejbiko2GwWo8jN1
         5ApBRpFBg272nzjRzmjmF0KAt2zUj/srkUiXmVKO3uQ/7Rhg4wthVCmYMfLvJvL9dD91
         IyOIB0wvw7mEoHRiH2sGoR5TQDCXJj3C86f9KwvXsAW0zCn2+EPWe4xfMYRKyCSL95NM
         5B4d+VsCVM6xnih8p2UvczmMxPYMlVFo4Iu2GnTL6/dSE9K0J0pLSQldp+F3hTd4z8mX
         3vwQ==
X-Gm-Message-State: AC+VfDzLGfZj/n7ED8HgTaJOa9UhjhvISUMIxabFG1qIz7I8qPOW12lL
        J3jdUwLSXbHkyuS02S2N3kJrXQ==
X-Google-Smtp-Source: ACHHUZ7oZo7G5GE5Au7PiQOHzixE8gijDSexUoXlU0n8rp+47guVjLqwzhNWj3i4s1C/PP2kjor3sg==
X-Received: by 2002:a7b:c3cb:0:b0:3f4:c28b:ec88 with SMTP id t11-20020a7bc3cb000000b003f4c28bec88mr1799069wmj.41.1685707704172;
        Fri, 02 Jun 2023 05:08:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c225300b003f42d8dd7ffsm1784513wmm.19.2023.06.02.05.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:08:22 -0700 (PDT)
Date:   Fri, 2 Jun 2023 15:08:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: s390: selftests: Fix spelling mistake
 "initally" -> "initially"
Message-ID: <bbd79f29-f490-4fe4-b5b9-2a0a85c31431@kadam.mountain>
References: <20230602102330.1230734-1-colin.i.king@gmail.com>
 <f0f0587b-5f19-82bd-3d58-bdb89ff59f8c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f0587b-5f19-82bd-3d58-bdb89ff59f8c@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 01:07:45PM +0200, Janosch Frank wrote:
> On 6/2/23 12:23, Colin Ian King wrote:
> > There is a spelling mistake in literal string. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Hey Colin,
> 
> I'm not a big fan of such fixes since they are most of the time more work
> for the maintainers than they are worth and accepting one can result in a
> flood of similar new patches. If this would have been your first ever patch
> I might have considered picking this but that's not the case.
> 
> That being said, if one of the other maintainers choose to pick it I won't
> stand in their way.

I kind of get dread when people ask me to fix a typo in my commit
message.  The drudgery of Sort by thread, Up arrow to the patch, Hit e,
Fix the typo, Add the v2 to the subject, The little note under the
--- cut off, and Hit send.  FML, right?  So I sympathize about not
caring about spelling.  But this is a user visible string.  Kind of.
It's testing code...

You should improve your process so it's easier to apply patches.  For
me, I type "i" to review this patch in context.  Then "ESC:q" to leave
vim.  Then "ap" to apply the patch.  It's six key strokes.  Anything
more than 10 key strokes to review and apply a patch is not Web Scale.

regards,
dan carpenter
