Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD2651484
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 21:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiLSU6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 15:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiLSU54 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 15:57:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE72DC1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y3so5398284ilq.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=KbhNEFItgqJpUb34PlBkSxussrLfWq638sk0HFl2FLNBYTaK/8B4hTsudLtq1bkC1w
         vw6Mr7C6FMx0V9UJAN8QRJjXtAVRsS8TGBOT5wg10yxC3S3lyss+1REqu2O661mXQsvS
         GhMwTohEAzhRfBnOPffbA8rBfCf3MI+2aQ93m3m48zG2Pi2C9W4eBEbbQ1XHOm3wy3Co
         2Pa7fSPzW6XYStHFMfwq9D1nABzUYP7WS7XSzJbojT+PG/EmyKDqIVBoTlN8rqJ9aBjZ
         WMUaHMyF4BODgsiwDuP18a2NdEZFL4LRWE5/PIE2lXJxqdegoOZ8cHXi7GUSgtRL76ED
         8dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=yKBR/c4i9QiDUCOC9Epr7dPxFEaXink1C076d7qzM8CuOXIxNy/0XSdo4GMOwqoh+X
         GghnCq9oQP8Twi+qprf8lJz9ZmVvoHQXhUqmpyb6wkFAyGIqNKOYWCP5NMvFJCU7q465
         Wx2z4P0o9OMY8rgge9VPklE2rkv48sGAW/jvL+VZcyu7lkviBUTa4YANeK5R+xfFVR9W
         SwTJgEvfFye/ZZNlVmxHw7wK6e0laeCbn+7I0/Xvb2v9/QJzCyirZQ0Wr67a0ztEl33t
         LKKJw7UOxJ0J+wp5i5s8QZyosf5X1HhL2eOOuE8GyQWL0PtXtt8PwotBS4VmWyGHwww4
         9knQ==
X-Gm-Message-State: ANoB5pmUA5G55vdMk1IkJILp1UJPMOkFlrA/ojbVT2cwMcKwFNTe/Iwi
        P/b8Taz0gHO6ZLKMdYCAjtpftA==
X-Google-Smtp-Source: AA0mqf5AJOutoWTrKLNf0NtrR35QSZ3Fj/E2MBNWrinQOUSozCbfMplOw5BVmBmSUVTZpkqDzkVokw==
X-Received: by 2002:a92:cd4f:0:b0:303:410a:f2b3 with SMTP id v15-20020a92cd4f000000b00303410af2b3mr25223881ilq.13.1671483474816;
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6550:fd9a:e118:25dc])
        by smtp.gmail.com with ESMTPSA id b16-20020a026f50000000b003987df8bccdsm1856814jae.43.2022.12.19.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:57:50 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Message-ID: <Y6DQTvOrHRZ8gjDz@google.com>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219183214.075559302@goodmis.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> With the new filter logic of passing in the name of a function to match an
> instruction pointer (or the address of the function), add a test to make
> sure that it is functional.
> 
> This is also the first test to test plain filtering. The filtering has
> been tested via the trigger logic, which uses the same code, but there was
> nothing to test just the event filter, so this test is the first to add
> such a case.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>
