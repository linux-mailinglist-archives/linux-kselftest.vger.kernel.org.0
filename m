Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147441986BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgC3Vom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 17:44:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34016 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3Vom (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 17:44:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so7288514plm.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Mar 2020 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yn2EFFvNTosGdc1SZkzpeyxuiukyNodVGp9r67QGVU=;
        b=bpeZdcqBq24MKzJHBJE91pRfIBpXinPzKbrQ4GX/YeDTXKB01LSPLNTQOt7E44+W7t
         v8f90McdsutcJ0MlMmHLxq5e8zNWLybnDRxKZBFDQJGPKLQXRdBNu711ZTP5rl0ApKnD
         nw9VQICDfBeRA7PjxpZTY8/epVSXjmJ6RVtUWemr46HgbWNkO51tzFBuE+6U2bL1LdET
         Ohl1WtpVMT2z4ylntco43RBk3tFwmi4PZRDz55n9EJhcDvNNQGgIpsGkMhan7FExJuxK
         ObIDEQGEDS398qO9oGi21vrqJALJAuLDp4B7E6d1rinMCCG9SYAEDeMnpKZBxd7LxhIK
         Ro4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yn2EFFvNTosGdc1SZkzpeyxuiukyNodVGp9r67QGVU=;
        b=DkLODuFVkGEJaMI2yNu9UiqQcIgqve90MA0P1X8Ctuw5YEN5nkATGknxaVFHBQM1Ge
         EMHNR1E7NjHK6bjSlW5RKzwI+Cl4Na/2deBxwrKY28cUgh7MTmtLUpJQfSj2J8T7fzzk
         iSOZzU88689ovFaWJ6wKQ+vNYb0lPZC2aUkoYgiCqgd2p1OAL8cv+KwD2geIlHFJr4Tx
         LYCUROrxP//AXEjkMjbW1GZ0DS2QY+3q2mCfLvoyFD558z7zthrsqyNCRq8zBUh9ixkc
         61yFtiyMSfyhuvWwqxfQ/GzQbkNtaXCH1okvToj50NjvZ5YTfbvfl+l9k3+fs37vaO4r
         Mvbg==
X-Gm-Message-State: AGi0PubSM3C86SgRzPYi6ecBxQuXUFE5axI3ziIUSiSz9+6YoaY7/tu+
        RzyzS2Sz1x2B+YLfX/LbrTkrl5DJXtse4/HJar4fmQ==
X-Google-Smtp-Source: APiQypKcBWeA2a78qibOeBIj0+BRUPByPOL1BDH+JU/y0XMU/KhLdSEPtbLI8a7RZPS7k8ND7t77e5s/H8puzIRkEoU=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr203271pjb.18.1585604680507;
 Mon, 30 Mar 2020 14:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200325225911.131940-1-heidifahim@google.com>
In-Reply-To: <20200325225911.131940-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Mar 2020 14:44:28 -0700
Message-ID: <CAFd5g45VWGgq=KOWAcM0cRKqrFg2=HhizZhX+0RsV5esWtJwaQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: convert test results to JSON
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 25, 2020 at 3:59 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Add a --json flag, which when specified when kunit_tool is run, calls
> method get_json_result.  This is a method within kunit_json.py that
> formats KUnit results into a dict conforming to the following KernelCI
> API test_group spec:
> https://api.kernelci.org/schema-test-group.html#post.  The user can
> specify a filename as the value to json in order to store the JSON
> results under linux/.
> Tested within kunit_tool_test.py in a new test case called
> KUnitJsonTest.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
