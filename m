Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EC731D46
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFOQCZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOQCY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 12:02:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86481E4;
        Thu, 15 Jun 2023 09:02:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso1699621f8f.2;
        Thu, 15 Jun 2023 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686844941; x=1689436941;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuwWGq/HZTxd+1ns842IDWBOssilEnZa9jIQGRloFJA=;
        b=f3q81OD5ezF4qhYMYUbnN+WtLhIvVBfMYV4g1xtJKhjK7wFmV5gErSXzTP1kZ6LBG5
         60ghM80tKdOR7U3UAP5VnGZSurLa+9hP1j9otZXiyL26B6cwyTDoxIhxdi9svkB3zLhk
         esXYJlm5FDk+2iiQY7csUZcjPJXM6uQG9V0ooaVGBejvlB9DSyKK+3+JvHItNmChoS17
         pixbcCgLEDzf3i6Q+dyVGxsLaf8/Qg/0LXxMWlskC4BAQzxxT66stQ9zr8SNfBR0QRn1
         pYJ2+8NGv7p4tMZWMcDyCPV7iC2tc5XMix76b+LpytznRXLHnjkSXEAA5UKBVcZ3QG/i
         iQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844941; x=1689436941;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuwWGq/HZTxd+1ns842IDWBOssilEnZa9jIQGRloFJA=;
        b=Zd2OrDFi0cuc5aESUjIG6VmBb/qF5EhynJ8C7UhuyQCFiJSOBMa1ajJQQ/J+TjiXJi
         fCOysuGNTEzTbWZ6n0aJnlXpXu9adOe3necv7Tgn7iOczqpiIsyQDQaNg+NUNJqmw+l2
         u/xs42/iLVDobbgvPSt3FGfwHgwUa4SNWkEtrCIJaPgTThJJP4vxSsu1BHLWfrjRWWCD
         xkWSzP+3QP3h9chzrJnA4gVvXDLuszpYjwi3eY7I7t1i0q/12VYQdcR3HOFrfnQm4c15
         Fm1tkVVnluCj9wggjKABgGviYeK7soB8bT9ikSNgT2DNRS2Dt2MkRf4zsCBIrHi1gYyR
         JUPQ==
X-Gm-Message-State: AC+VfDyXQhk9DdN5RQCoedyVbmuMwzKtVKUcwvFHEYAbm4jLxO+vQP40
        wLFSU6pS6TCMElxc0dvl3uM0GhYfo0Pxjg==
X-Google-Smtp-Source: ACHHUZ5MqPAJT3yys/PhcsaiSphe9kaP3XoGrFoelWEJzR7ufELNuAC+SxXIe55D9uq6SoyF4MjE5A==
X-Received: by 2002:adf:ff87:0:b0:311:1b27:74a6 with SMTP id j7-20020adfff87000000b003111b2774a6mr569553wrr.28.1686844940673;
        Thu, 15 Jun 2023 09:02:20 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id f9-20020a5d6649000000b0030f9dc63ff1sm19454197wrw.88.2023.06.15.09.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 09:02:20 -0700 (PDT)
Message-ID: <7a853516-9da5-811b-1e9c-84e5483a8a08@gmail.com>
Date:   Thu, 15 Jun 2023 17:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shuah Khan <shuah@kernel.org>,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>,
        Benjamin Gray <bgray@linux.ibm.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: file removal issue in tools/testing/selftests/powerpc/mm/tlbie_test.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Static analysis with cppcheck has found an issue in the following commit:

commit 047e6575aec71d75b765c22111820c4776cd1c43
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Tue Sep 24 09:22:53 2019 +0530

     powerpc/mm: Fixup tlbie vs mtpidr/mtlpidr ordering issue on POWER9


The issue in tools/testing/selftests/powerpc/mm/tlbie_test.c in 
end_verification_log() is as follows:

static inline void end_verification_log(unsigned int tid, unsigned 
nr_anamolies)
{
         FILE *f = fp[tid];
         char logfile[30];
         char path[LOGDIR_NAME_SIZE + 30];
         char separator[] = "/";

         fclose(f);

         if (nr_anamolies == 0) {
                 remove(path);
                 return;
         }
	.... etc


in the case where nr_anamolies is zero the remove(path) call is using an 
uninitialized path, this potentially could contain uninitialized garbage 
on the stack (and if one is unlucky enough it may be a valid filename 
that one does not want to be removed).

Not sure what the original intention was, but this code looks incorrect 
to me.

Colin
