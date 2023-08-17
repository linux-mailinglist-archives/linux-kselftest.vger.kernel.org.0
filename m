Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BE77F320
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjHQJWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 05:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349484AbjHQJVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 05:21:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE219A1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 02:21:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68876bbecb6so1759897b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692264113; x=1692868913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQs2iirMBYyeAMahOY50mDUR4NQKE6tkGZ5ZARpOjG0=;
        b=fPihYR+ioPrcnNvKWxJLA3AKVfaCi+u62mnwS5clWqWQG0qdhsfFZx9J+PjzLJKjib
         0dxF6uuLdW392GKiDhckmYR8XXBk9vn0ET8erRmYrXuMUMs2jyGF637+mEOHiONFvSYF
         lZ6L3pGsdQfrR0rqygxtIwvHl5sh49wnkZXbOboD4pt/fLlK7WPu+Yt2zVvIOlWwq6GI
         cCSY8SBmmSOzYaI+KlNMVcsw2zlfnG+FNdZ+Lo/HcAGkwZfuAAFRT99ibu56T9Z3M/xU
         yOjJDLtpElcB3ligbcJ/C+Ojn3PkSX1oyc8vAUD9penYErHMVv88A5c3WqIpon4Ok23a
         65jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264113; x=1692868913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQs2iirMBYyeAMahOY50mDUR4NQKE6tkGZ5ZARpOjG0=;
        b=Nnqq9gYI5zxY86J5ZzLYE3T1ieUO3i48Ma7U2+F9nIfKDYWHm5UfeENK8fKCFThGNk
         FHG04KbQjOFC6APcTt/cUnEYtkR0i9iYmY+cLXV9SpY58Vae9NWs6GHHO6T0C6BtNhUM
         N16V2IV9NDav6z3qd8xPSWL+KIV7zLF5OmUPQjL4rx/fiyUPPCHheIbtF18RkLEyk3l+
         yolYCgH7tRoDMWK2vztI5wfrPT+kRdLbnvO6e2NgbmgVXK8HXjBB17YmJn8pJxuB+Hbr
         gm3o6lfFAi22+O+d3F5LFRVY733UtfYMZhzh+ZNKeOPKsP+XHFekzPJ9oANkC/3JF4pR
         Fp5Q==
X-Gm-Message-State: AOJu0YyBKXOe/0Ehe5zBk5bjsGgUTPkILC8ozoebkKytQLYkjltXOlgf
        OB67S2iwz39DfWsZzxcOQ/8=
X-Google-Smtp-Source: AGHT+IECzFfJxHoNRPkfwgfOAyjabTcKnbc+FzB0G6CHancwE/uNi8x0hMrYxi2xagXdY6Qlk9e2PQ==
X-Received: by 2002:a05:6a21:3e0c:b0:144:5d5b:8e24 with SMTP id bk12-20020a056a213e0c00b001445d5b8e24mr4198600pzc.24.1692264113469;
        Thu, 17 Aug 2023 02:21:53 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:1afa:cf81:3a3:6ec8])
        by smtp.gmail.com with ESMTPSA id n23-20020a62e517000000b0064f76992905sm12376503pff.202.2023.08.17.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:21:53 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:51:48 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v1] selftests: ipc: Updates the msgque test to use
 kselftest framework
Message-ID: <20230817092148.GB72739@atom0118>
References: <20230723064154.89443-1-atulpant.linux@gmail.com>
 <26d32ad9-6b83-d959-adae-d7181695db18@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d32ad9-6b83-d959-adae-d7181695db18@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 09:45:10AM -0600, Shuah Khan wrote:
> On 7/23/23 00:41, Atul Kumar Pant wrote:
> > Updates the msgque test to print the pass or fail status after the
> > completion of the test.
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >   tools/testing/selftests/ipc/msgque.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> > index 656c43c24044..513b1265bb75 100644
> > --- a/tools/testing/selftests/ipc/msgque.c
> > +++ b/tools/testing/selftests/ipc/msgque.c
> > @@ -9,6 +9,7 @@
> >   #include "../kselftest.h"
> > +#define NUM_TEST_CASES		1
> >   #define MAX_MSG_SIZE		32
> >   struct msg1 {
> > @@ -197,6 +198,7 @@ int main(int argc, char **argv)
> >   	int msg, pid, err;
> >   	struct msgque_data msgque;
> > +	ksft_set_plan(NUM_TEST_CASES);
> >   	if (getuid() != 0)
> >   		return ksft_exit_skip(
> >   				"Please run the test as root - Exiting.\n");
> > @@ -243,13 +245,16 @@ int main(int argc, char **argv)
> >   		printf("Failed to test queue: %d\n", err);
> >   		goto err_out;
> >   	}
> > +	ksft_test_result_pass("# Test Passed\n");
> >   	return ksft_exit_pass();
> >   err_destroy:
> >   	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
> >   		printf("Failed to destroy queue: %d\n", -errno);
> > +		ksft_test_result_fail("# Test Failed\n");
> >   		return ksft_exit_fail();
> >   	}
> >   err_out:
> > +	ksft_test_result_fail("# Test Failed\n");
> >   	return ksft_exit_fail();
> >   }
> 
> I am not seeing any value in adding these. It already has messages
> in error legs and it prints totals at the end:
> 
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> thanks,
> -- Shuah

	The stats printed at the end have no account of whether the test passed
	or failed. As seen in the totals message at the end, all the values for
	various test results (pass, fail,xfail, xpass,skip and error) is 0.
	With this patch we'll get the totals at the end of test like:
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
