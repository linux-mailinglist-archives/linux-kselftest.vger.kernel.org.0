Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8B769947
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjGaOS4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjGaOSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:18:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6282EC9
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:18:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso42265495e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690813121; x=1691417921;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWLazBfIdP3X51iv8GdfJ9VxvHQdwzOqLkdacF01+h0=;
        b=Spjs43fk8qK4rp4sOMnoKHZAAhL5DBiVzz4oXP4drM5CHj7p6OYsqz2xS0iG/0RBcd
         pLIBPmNqF/G+8RQ24ImSDRomEFFs/rs6F3ZV8oO14M3nI7hGL0mRM87haOXQQc1FYMIC
         ZBDGwZ10O5zhk2ccRIplrhWqSfDnqP8v6XCDQ2Wx90GvR1BYo2+PM6Qsb1QzFrqkMNQd
         EGbbLOtX+S7XrRSB2GLE7Hy03zrbJWDwxBEz43PeSmto04NfNolzbZbAGl86zDkUmnBh
         MvkKnOuJrqyU3bs2+Upu6cPQHMmc2WxiKOGbxHyt0Kcsr4j13TgBgGRH9FFQkQyT6FzY
         wkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813121; x=1691417921;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWLazBfIdP3X51iv8GdfJ9VxvHQdwzOqLkdacF01+h0=;
        b=VGrftQo5johDTNqK9BNziwF32id3RDCHAbDlPOiyI1/4FPSj0h9twGLTLdifdrfAl2
         Gfi4Id66vN6Y7DocnVwlqvSdtjqQsQOV0aWb3CG3JrgLTbA1KQHPBmH7GOTXV6cCwmJh
         JL4rszyxBxyawo3nkVw//lO9fsOCtxvKc+oVRqKiPA4l5cAMrbrRlt02OOB/6nZScRPy
         Us5xY5QCiOh6oCG5zHq7FkGsmWe6j9Mvzhh2+c8xLmqMDvrej3VKDZg1OL29JkwJ+EUV
         vdHDnaBLLcTPejj+u9AxZJHQ5UiuHYJtJldrPXmcfJ6eyH544GC4UJfAXXlkGHOgTYZ6
         R/QA==
X-Gm-Message-State: ABy/qLaYjo8UrKFpfRwGoIUzOUXTeFRAQQDbySeIr7bhMLT/ys4bqXM1
        p/BjiTmI/GoQdbGKLMQ9K/NVkQ==
X-Google-Smtp-Source: APBJJlGfKaOyBqd2PbQEFDzwD00ixuWmWMZHYqac2h/aX0LsB9MJVopQWjaqaW22olEFfP85mUsAUA==
X-Received: by 2002:a1c:4b0b:0:b0:3f8:fc2a:c7eb with SMTP id y11-20020a1c4b0b000000b003f8fc2ac7ebmr79894wma.5.1690813120892;
        Mon, 31 Jul 2023 07:18:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm14167963wmm.23.2023.07.31.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:18:40 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:18:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     kuniyu@amazon.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftest: Add test for SO_INCOMING_CPU.
Message-ID: <fe376760-33b6-4fc9-88e8-178e809af1ac@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Kuniyuki Iwashima,

The patch 6df96146b202: "selftest: Add test for SO_INCOMING_CPU."
from Oct 21, 2022 (linux-next), leads to the following Smatch static
checker warning:

	./tools/testing/selftests/net/so_incoming_cpu.c:163 create_clients()
	error: uninitialized symbol 'ret'.

./tools/testing/selftests/net/so_incoming_cpu.c
    146 void create_clients(struct __test_metadata *_metadata,
    147                     FIXTURE_DATA(so_incoming_cpu) *self)
    148 {
    149         cpu_set_t cpu_set;
    150         int i, j, fd, ret;
    151 
    152         for (i = 0; i < NR_SERVER; i++) {
    153                 CPU_ZERO(&cpu_set);
    154 
    155                 CPU_SET(i, &cpu_set);
    156                 ASSERT_EQ(CPU_COUNT(&cpu_set), 1);
    157                 ASSERT_NE(CPU_ISSET(i, &cpu_set), 0);
    158 
    159                 /* Make sure SYN will be processed on the i-th CPU
    160                  * and finally distributed to the i-th listener.
    161                  */
    162                 sched_setaffinity(0, sizeof(cpu_set), &cpu_set);

Presumabley ret = sched_setaffinity() was intended.

--> 163                 ASSERT_EQ(ret, 0);
    164 
    165                 for (j = 0; j < CLIENT_PER_SERVER; j++) {
    166                         fd  = socket(AF_INET, SOCK_STREAM, 0);
    167                         ASSERT_NE(fd, -1);
    168 
    169                         ret = connect(fd, &self->addr, self->addrlen);
    170                         ASSERT_EQ(ret, 0);
    171 
    172                         close(fd);
    173                 }
    174         }
    175 }

regards,
dan carpenter
