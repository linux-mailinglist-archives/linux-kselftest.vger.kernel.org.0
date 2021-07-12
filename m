Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4734A3C62A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jul 2021 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhGLSeS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jul 2021 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhGLSeS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jul 2021 14:34:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB0C0613DD
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k11so23925966ioa.5
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=P0ksw+vlwVta+6sykFVSvdgotDV2Ib4mvz9CazIitN8WqC62CGc26VJjIWLL5HrDRx
         Gm+fTShmINE+dnzCsGfEbq0BvadYCsjJj2bXKlpPlNixXaqFAjfvns5UeV2gZtMn/qIH
         OVN4mgJycmzX0WSjzL+UgEmfz1pD+t6emBQ0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LgizhMtK9J0wIVIMFU3xipTGuHnEvtr8IUFF/Ttb7XQ=;
        b=IiyV0D57EISnlTTou63jRopPGf1YlknukgpbU+MOm+8v7tLJ1dLO9w/BwCTXUGYHYp
         VshttLfIueP5vpmpYZ83uKkpCkv1ldg9b1o4RvWiR6HGUE2Iwr6qO65qAtFhQw0CDoMA
         Y2+CE1zNc4w6wGOatMitrEswjqzPKdusCrUjAByDUZqxS/OJxzCfzMW3wn0ySdFUG2Hf
         qleZ8qzCV2K8MypPuaERc6N4O3GlcfFmvRgv1tDjNq3ukbysCeTD2RA8MqaoJ8e0A0/y
         P5We4h+fmPwWe574Zeau3ASk3Wmob9gWdAIdTJA+uJhzDDGvXuZj9T4MzqEa8aFIj9Qa
         dXDA==
X-Gm-Message-State: AOAM532Mc2+eFC+hSVUQy3GQZXJLbUYWfe3IEufi2n8upSkc9/xZx71I
        Ulm05bikAt6U+HQlW+pUsYyXYA==
X-Google-Smtp-Source: ABdhPJwgR47turz9PqCQknUdJuTqQOEvWs0Zy2zl48axnG9Z6QY5OInQZJ2yOMTpEOEcb2DMfyxqKA==
X-Received: by 2002:a5e:9e4a:: with SMTP id j10mr215619ioq.29.1626114689487;
        Mon, 12 Jul 2021 11:31:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h12sm8674093ilj.6.2021.07.12.11.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:31:28 -0700 (PDT)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: BUG: lkdtm stack-entropy.sh test hangs
Message-ID: <38ca8e69-1385-6035-5ac4-2ef45cfc8141@linuxfoundation.org>
Date:   Mon, 12 Jul 2021 12:31:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

lkdtm stack-entropy.sh test hangs on Linux 5,14-rc1 - I tried
root and non-root cases. Both hang.
  
# selftests: lkdtm: stack-entropy.sh
# ./stack-entropy.sh: 13: cannot create /sys/kernel/debug/provoke-crash/DIRECT: Permission denied

If you have a fix for this, I would like to get this in soon.

thanks,
-- Shuah
