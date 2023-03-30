Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B914C6D0A3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjC3PpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjC3PpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 11:45:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AFDBE9;
        Thu, 30 Mar 2023 08:44:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so14319378wra.7;
        Thu, 30 Mar 2023 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680191086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fI7AZ+BouKPLvpCbD8t+T2h0CHzY77rJJJKu+MTUpws=;
        b=F3TtuF6hfWReD8hZK0XtAmOJIoUSpU1ag8x9zj8hcMFyLy+4usJWfOIalNvXCvKrls
         ao3k2lFe4FItzV9lh+q2lLf4u69zdyKM2rzBmDmGsP0ocO2dTPBmPA7bDXlZZJAKTjQ2
         gHdyu4oOBj+Cus7FVcWaG12NPJ7yO9MgZA9Bhux7673CVfraZWl5bycfWH+ppr0idW3l
         jaoLPBNzczNuNB1ldqfG3sPlWkEkOungjKWmviLT8XERxeHIPvLT+ZEzBsxG4pVZ+T3s
         4bfNrOhUc6FEMiFQU8MvGPWh5FpKtodFLF3xIttpJwgIP1TpWBgzUw9A9IfE890LXbw2
         w6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI7AZ+BouKPLvpCbD8t+T2h0CHzY77rJJJKu+MTUpws=;
        b=PtXSkecqTShPoEqL0EjKaiKE8hpR9GYhbmjvQZ35bD99AXBDb/cTqmJ1m9e3v0AYiT
         gFgXKfVhDcvgSK38zKfaHaEiQXOPaLyUo4tzLH9gZTsYWKWcDkxc75shkRlJ9wP1chmI
         ofa/h9Q7xITpzZVwCl5VS9RI1aGd7yFNjKxUxOotnyElpZVf4ZoiPizcwHXriLAuOUIz
         0Ga64E05QhpMF40dRCBbr9c2lRiODm1ke5RNg4mSUzIwEpnU+5z2wW/vuaQ/UhazZJxP
         w0C7N7qqFxesdVfY3bUQ3MPgnnWv+GaoOH1ePRqfaY6BtfqqmmpQNL7SKX/5ALAtMoIL
         jokw==
X-Gm-Message-State: AAQBX9dW7Accs7Z1/GD+cWyD48rCa9yQM7b0LsEr5jNF9CeB5ujrhJiN
        hVn7zVV3gKKR2DaNV7oa97A=
X-Google-Smtp-Source: AKy350aVAFgCRzr5YIakavp46G17LfFoY8SAxHZMGfzkXyoCm4NU5ADBuxXOcGfcL9m/Zl5lEev7Mw==
X-Received: by 2002:a5d:58c9:0:b0:2cf:e3a9:c189 with SMTP id o9-20020a5d58c9000000b002cfe3a9c189mr19937729wrf.3.1680191086562;
        Thu, 30 Mar 2023 08:44:46 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm24689035wrx.25.2023.03.30.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:44:46 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:44:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [BUG] [PATCH RFC v2] selftests/firmware: copious kernel memory
 leaks in test_fw_run_batch_request()
Message-ID: <5b103196-68d0-4d42-aa66-779af4d78532@kili.mountain>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
 <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
 <dce6ffbe-7580-db1a-dd24-798be27b3a26@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce6ffbe-7580-db1a-dd24-798be27b3a26@alu.unizg.hr>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I admire your enthusiam.  :)  What about if we just did this?  Does it
help with the leaks?

regards,
dan carpenter

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..626b836895f4 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -895,6 +895,9 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs)
+		return -EBUSY;
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
