Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94358CB45
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiHHP2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiHHP1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 11:27:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2501403B
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 08:27:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so8358646pfv.13
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Aug 2022 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6EhfGnyFyfo/ortCKW/6YMzIhO+eS1k9nO7B1q/r9pQ=;
        b=ipcWPQ4r5SOTmHdFaWDyzYl7sr/T8mVvXFrXPnKe3sXnhoCaUiHdceGHpYs4VoIT4g
         egYf2m1+rJ3W9RLYDihkilDg76flKhNbU2JozYCXUnD0YqnDdswjFiaIonr1YIYriaiu
         BW81ij6knRBoY9s9PatXvqOPnOs1NdC/VP+KabIrtHffpoki1hBP98jMiRPJZCZLwGdp
         7tYLL47JtnfP25Y87U5onjHwpwQSe0jHZIXb3Y4I/VW+kJ7tfnRHWj/N2gji9wf/CGp8
         OYyudyJObGevxU494U7SHLlOxaW4vf6rDWAP0tkFqu2sq6juFi8cI7mo5tYXuDi1mhhW
         oMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6EhfGnyFyfo/ortCKW/6YMzIhO+eS1k9nO7B1q/r9pQ=;
        b=1imMxpVHkKHtwd9aFUoZ0RDrnetjbb/Hdr7/HSWqY0mcAApIEpvsB3ck3mGGxIMSrX
         8nn8KrGWo0/ITsuAOvS5TAPB3ycPMqUeD8hCZjSpbEaRrQgD6kshlOvYAjs6zE338cNc
         FlqF5/vaGVL01RZA+B03jghK3P0DEfmCXxv8Boe52bs0Wc/EwiGCO4WTnKyBZ8/L0KWN
         unm96q3mQ+rpeWum96EOGmdnIPl70/SLVD7TbK2tNLiJxaCnVEVbYLZLjahLKLjso9sH
         Cpm5Aq6wHG5fsmjL46GMunEPv7SzTFkmABMcJ6ioQPW/7jVwBIn0X545W0u+xNXAMcHa
         LH1A==
X-Gm-Message-State: ACgBeo1smYAwSKLB2K1HawHI4SQhvmsH/3M3IuzO6SfcXRy1wSBLgtdp
        3T6JEniF8fxXMUcE+KrzAGHgXw==
X-Google-Smtp-Source: AA6agR4Rnf8A+8xtrvnphN11wUQN7ICXf7ikA7BaMe/wYY9EnMpRPjODRrEy9Ai4TjucpuH/tIgKlQ==
X-Received: by 2002:a63:6304:0:b0:41c:1926:2aa9 with SMTP id x4-20020a636304000000b0041c19262aa9mr15723014pgb.425.1659972473399;
        Mon, 08 Aug 2022 08:27:53 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c21300b0016be368fb30sm8758280pll.212.2022.08.08.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:27:52 -0700 (PDT)
Date:   Mon, 8 Aug 2022 15:27:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 1/5] x86: emulator.c cleanup: Save and
 restore exception handlers
Message-ID: <YvErdKUzy/ML8faK@google.com>
References: <20220807142832.1576-1-mhal@rbox.co>
 <20220807142832.1576-2-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807142832.1576-2-mhal@rbox.co>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 07, 2022, Michal Luczaj wrote:
> Users of handle_exception() should always save and restore the handlers.

Might be worth calling out that #UD is intentionally left alone and will be fixed
separately.  No need for to spin a new version though, Paolo can add the note (or
not) if he wants.

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
