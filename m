Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316E85BD50
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfGANxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 09:53:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfGANxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 09:53:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so6613936pfy.13
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnqcdAZEqlhe5AvSTX+V5wDK1OqDo6RCXWT/qry/0jg=;
        b=XWregEDl1FFMPhgi4vXgSGCiek/WrfkHRgLPn5FgA3IxY5gqLSnf+5oM7t9Shhq0tn
         k9ig4d4b372SkcPvNZ2VUnZfZjIBURPZFmBU8+pS1u5GZpAe/nX6VsDTDksvNUpBbxkc
         ttX2Jr0lLx1e8hSiszEog64NrgL4txrFPVS4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnqcdAZEqlhe5AvSTX+V5wDK1OqDo6RCXWT/qry/0jg=;
        b=Ebgk4Mzxef8nKmjWfKfE3sDA4HNN8Br4j4BalrFmPMshx9foUJnuqGCSi19GlDVpx2
         sOLJeP62YzKYtBKzkY/6dctS86eHRRcR3n+br0TEnsWencQewFN3mA3Gc5wdUWRycPU5
         h3EAFYKjy8WWUDiL2ZIU4Igl4mfC7kO2BQYzwPBMk48csOVQE0hHXRfzCRSXy4LZEe7t
         f/BraeObOvv6+LI/52Dz5wACBDGe9O/G5gcsLm0ecLrP19AW6t1Q4DtHSmDdy99BcwCf
         srs/SRcS4QhiyBqcYGksgY121MPkOW2l1aN2ADKALWoED2p8EpzHttEZagsMN7UZ+noO
         dbKA==
X-Gm-Message-State: APjAAAX2e1NWlICwl5X8w8tnb/XeoS8ozIsMo+4CWnxLPuLtOJhIawiV
        lDohMyS5qGetDjgB/SrmsBt3aA==
X-Google-Smtp-Source: APXvYqxX5xXZI0X2mxnuICMgqyXLY+28omTo2AX9jZBNCHB9Nez+eCLHSmiTzqOVBM+4vcQjsnymdA==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr11833928pgc.346.1561989228598;
        Mon, 01 Jul 2019 06:53:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm11274343pjn.32.2019.07.01.06.53.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 06:53:47 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:53:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 1/3] rcu: Expedite the rcu quiescent state reporting if
 help needed
Message-ID: <20190701135346.GA167294@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701040415.219001-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 01, 2019 at 12:04:13AM -0400, Joel Fernandes (Google) wrote:
> The t->rcu_read_unlock_special union's need_qs bit can be set by the
> scheduler tick (in rcu_flavor_sched_clock_irq) to indicate that help is
> needed from the rcu_read_unlock path. When this help arrives however, we
> can do better to speed up the quiescent state reporting which if
> rcu_read_unlock_special::need_qs is set might be quite urgent. Make use
> of this information in deciding when to do heavy-weight softirq raising
> where possible.

Just fyi, TREE01-06, SRCU-N and SRCU-t passed overnight testing with this series.

