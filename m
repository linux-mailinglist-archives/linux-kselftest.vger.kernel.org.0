Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B66B50AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 20:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCJTHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 14:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCJTHW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 14:07:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9F136D03
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 11:07:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q6so2438455iot.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678475223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWqtsiqhGUvNVAxgRGNmyViFn5ukJIP+nu+2X15PDag=;
        b=lP+cRiqQYogRnG8ytsvBRJH62sDPxM3+CDXZhL5XklrS+EMZfkeHz6srLEEcNzUSKm
         DQr6N4ghWlycKeo8HTR6udWthHKnHA7p+Ry3Ppb6ljZKee48XYYfD10MMFYqFbKq2GfW
         utJapnTS8BCSAfrd10vVbnnse/BcUYaInkirScHdlhRqAPQvySuKfHHF+hna6jkMbTjg
         6U6WqLvkSxMbIpNEneCVMdD2tkpMgcJW3ntwItTTvy0/L26WDIzhDwqGm6Mc/l8JSwwd
         XUAmsvkJbXHXjO8TP2D8SoCozFxRHUi2hiAfZzIu97sY/JgQCM3B5mqm+d6ANOxJwKix
         +edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWqtsiqhGUvNVAxgRGNmyViFn5ukJIP+nu+2X15PDag=;
        b=cEDt80jZuti/L4SQenOzwpYaGpve97iFX0yUe2rjHhDRpK0L8OLf7WWeDDg8LR1tT9
         YN5/o5TLcszb4LIBK7ctjbRK84hOieefO7Fvj1v37e5mbkIOSC6jXJa4mxAQA2ve6VDM
         5AX9scH0NkmxiyyymHwCaeLiiOdAin9Nscl1N0r0F/4l5g46FxlDWg36PRaLh71GqynJ
         alDFoc8JUyXhUqzwKjR/o6h1UW9prA3CrWe/nyUXb99oOrGYuszCokByNghMPiV78If3
         +R/e1cGldwLvGTWKxVgyH2Rlcuq9i5puid9MiFZn8ob7YHEdWIOXe2hkbMLSJvixUnUE
         GZHA==
X-Gm-Message-State: AO0yUKX/u+9HxsjpAesL3VvMURnK9SXhoPPg04ZPZF6g8nFpKa3uAZvj
        PjUOt8T+3sURrYfNJkQzOfJ0jQ==
X-Google-Smtp-Source: AK7set98xZN8awZ1NN+vEagnjcoQMPk9okvoD5NJwhGvEkQKUqEiVikUd2YXenveqqScArjHta7Ztw==
X-Received: by 2002:a5d:8482:0:b0:74c:91c7:8794 with SMTP id t2-20020a5d8482000000b0074c91c78794mr4158053iom.21.1678475223076;
        Fri, 10 Mar 2023 11:07:03 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4031:1c3f:5d8e:1b77])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d93c2000000b0074c7e84d0c8sm126473ioo.55.2023.03.10.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:07:02 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:06:58 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310190658.GA3723158@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230310032921-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310032921-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 03:29:49AM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> > Changes in v2:
> >  * Dropped patches which were pulled into maintainer trees.
> >  * Split BPF patches out into another series targeting bpf-next.
> >  * trace-agent now falls back to debugfs if tracefs isn't present.
> >  * Added Acked-by from mst@redhat.com to series.
> >  * Added a typo fixup for the virtio-trace README.
> > 
> > Steven, assuming there are no objections, would you feel comfortable
> > taking this series through your tree?
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> if you want the virtio patches through my tree after all, let me know.

Yes, please, that would be great.  I'll send out v3 with the few patches that
haven't gotten a response, but I'll drop the virtio patches assuming you've
got them.

Thanks!
