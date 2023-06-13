Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FD72ECE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjFMU1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFMU1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 16:27:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912201BC3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-650bacd6250so4624624b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686688015; x=1689280015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnlFW0kd0Y84IfhvBXl3XnXnVsubhiNgScvuLZLkXZY=;
        b=eu5Fl0EsFg77AB7lt65Txl0r6hk9Wb2IzCYKpbHX17N7W/zY4Hj+8zbZvi3X4kjDF9
         gQ7AtYkCRyv1seyCnxYizI7b+zkOr6wdbzQGGM2NI3b9e4D1vcOjBfDKjgGgRGVQ9L5f
         nXIR+w0GCmjhMwkeSrG0TTQkcQNUBEr/zDmrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688015; x=1689280015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnlFW0kd0Y84IfhvBXl3XnXnVsubhiNgScvuLZLkXZY=;
        b=heJ4LtTyJWfjQiRyiOLPpaus3Xl5Y8p7ZO+tulTku3O7zHxC9z84NpSlDhPlsx7UOq
         f0Mo2ymJ5PRgsAgILBFOJi/NMlrp71phYBr1/YCcUgSIc5BCkmFJThXaY9DpqPY3g/pj
         PXVh3vZeNH3goKr4d2mN5qliU+oCY2XDTQmYpxnUc5jt6Yh1HXEN4CMUIRPjfxUEqSCr
         q00ZwHV4LSV3dRYUtiDretDGV9906thdx6XEdVXNRjIXwp2t4yLDmXexeOR3HRhQrH8V
         QvhZooCqP9a2NWk97CH+z7+IKKk0efboSdeuRVkOGwKgxK9j7OIZrcTrqPSWRDaNpMlK
         4v9w==
X-Gm-Message-State: AC+VfDzfQgHy0E0XOhKjKW/DW5QLCna50baLU9xgKQp3RA8oXJTfCLut
        7J1euPUmuItUKY29jrPjAeU//+ok/yk6t1zFMnI=
X-Google-Smtp-Source: ACHHUZ7ey7QxrIE5aHkLsg7FKb1+58NQaGZB35HpoSVqVkMJMNUaI1Tt/kaloGUkLfAEWY1BsJy2mA==
X-Received: by 2002:a05:6a20:7da8:b0:117:1c52:ba7c with SMTP id v40-20020a056a207da800b001171c52ba7cmr15082251pzj.6.1686688015095;
        Tue, 13 Jun 2023 13:26:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001b392bf9192sm7647778plb.145.2023.06.13.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:26:54 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:26:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Subject: Re: [RFC v1 3/6] kunit: Add ability to filter attributes
Message-ID: <202306131324.5B69ABC@keescook>
References: <20230610005149.1145665-1-rmoar@google.com>
 <20230610005149.1145665-4-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610005149.1145665-4-rmoar@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 12:51:46AM +0000, Rae Moar wrote:
> Add filtering of test attributes. Users can filter tests using a
> module_param_array called "filter". This functionality will be added to
> kunit.py in the next patch.
> 
> The filters will be imputed in the format:
> "<attribute_name><operation><attribute_value>"
> 
> Example: "speed>slow"
> 
> Operations include: >, <, >=, <=, !=, and =. These operations do not need
> to act the same for every attribute.

How is the "default" filter specified? Is explicitly unfiltered? (i.e.
"slow" stuff will run by default?) Or should there be a default filter
of "speed<slow" for the memcpy conversion?

But yes, I'm a fan of this whole series! I would much prefer this to
having one-off CONFIGs for slow tests. :)

-- 
Kees Cook
