Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359A74DF51
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGJUbN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjGJUbE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 16:31:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E0D10F6;
        Mon, 10 Jul 2023 13:30:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6687446eaccso4310101b3a.3;
        Mon, 10 Jul 2023 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689021017; x=1691613017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKmlv+wxXqaSoHkhgo1UfUl18TmiO3xK9oBQKtdH8iQ=;
        b=KHal0/ZUL6wMKbvmzzrwC7IC3NNlsfwGTHYhP6y+gItbJTQGgjsXOdqklPgg5cEymE
         fSGru2UrWEvmO4KeaEK2ywvhLz8TAHwz+wfx8Uw+5pbZlTWhnsHXWfqdwJMMkVTn1GvU
         IoP7cVUFi5tMbwJj+WEfkrps1JDOx9mXKTmdYVKay7fbTuzLVSEXqjA3KeUtec1c0lsy
         MW9I2g4Y2jdbfJpbYHcaSZoz+mNcAbJpumNbTZnnW0X08WAjGOMVTSipoVJjmaLTPAky
         bcN1fqypBgny8jHWYvIw787G+Iq9+nZBfqKP/tgVgTZWEYxYBGx5iYw9z8A7VOiVbzkf
         cE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021017; x=1691613017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKmlv+wxXqaSoHkhgo1UfUl18TmiO3xK9oBQKtdH8iQ=;
        b=FN4sjXIQf1G+K26xZ07hR3Wg90mBK9oWRj/0MNzfW+uQ+EgNMU99tVLyy/deDql9FJ
         /PIEu6WAMQ5Vyg3JY1OYBZIkqNv1dV4QgM8alT7gRoPYVHvtZ8H38nH1eCaf/7G5RVR2
         TKeiEV1ZMthWL5h281zaG8pEV87pFDQDiu1NOaO+9GqQ34GcgHOgtITeXrIbD5Z1WSYS
         dj/eFC9Hy9pJqEBaFbDhkVEJi1FCywDmin2Z1kQMXR9IT1vsPPPYaVmpnckDWnizTrak
         g0pkW3ZmCGmpfkxnFk+FhS6NS3biSvz2zd+SIS0DhiaJnW233OtySHQZBfxtXZrcKFWB
         YTIA==
X-Gm-Message-State: ABy/qLaSUnSLeeeqAgmx+pGTArMXBP03fW5UXNw1BAp0l/Q0RsVeiCVU
        yWbF7wvvOgyc8awU13m5xzNbXmdYr7Tn/g==
X-Google-Smtp-Source: APBJJlEeOqtT9NTFjVa6Jb2codPbzzAa4kndfOgNgD2nhwXpPngvHjjmEwaY1OrO6Qdb2R2rZufPOQ==
X-Received: by 2002:a05:6a20:8f14:b0:131:173b:fd94 with SMTP id b20-20020a056a208f1400b00131173bfd94mr10411086pzk.29.1689021016779;
        Mon, 10 Jul 2023 13:30:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id w1-20020a637b01000000b0053f06d09725sm122349pgc.32.2023.07.10.13.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:30:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:30:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 0/3] cpuset: Allow setscheduler regardless of
 manipulated task
Message-ID: <ZKxqVvgh_ccdR0Lj@slm.duckdns.org>
References: <20230703172741.25392-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703172741.25392-1-mkoutny@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
