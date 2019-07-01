Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E05C41A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGAUDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 16:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbfGAUDO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 16:03:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Jx0dP052115
        for <linux-kselftest@vger.kernel.org>; Mon, 1 Jul 2019 16:03:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfrpe0e6m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 16:03:13 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 21:03:12 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 21:03:08 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61K37AU53936414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 20:03:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC97B205F;
        Mon,  1 Jul 2019 20:03:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111EAB2064;
        Mon,  1 Jul 2019 20:03:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 20:03:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 270A716C2BD7; Mon,  1 Jul 2019 13:03:10 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:03:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 2/3] rcu: Simplify rcu_note_context_switch exit from
 critical section
Reply-To: paulmck@linux.ibm.com
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701040415.219001-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070120-0052-0000-0000-000003D90CE8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011361; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226040; UDB=6.00645424; IPR=6.01007252;
 MB=3.00027541; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 20:03:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070120-0053-0000-0000-00006187F46E
Message-Id: <20190701200310.GP26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010231
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 01, 2019 at 12:04:14AM -0400, Joel Fernandes (Google) wrote:
> The rcu_preempt_note_context_switch() tries to handle cases where
> __rcu_read_unlock() got preempted and then the context switch path does
> the reporting of the quiscent state along with clearing any bits in the
> rcu_read_unlock_special union.
> 
> This can be handled by just calling rcu_deferred_qs() which was added
> during the RCU consolidation work and already does these checks.
> 
> Tested RCU config TREE03 for an hour which succeeds.
> 
> Cc: rcu@vger.kernel.org
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

My first reaction was "that cannot possibly work", but after a bit of
digging, it really does appear to work just fine.  I therefore expanded
the commit log a bit, so please check it to catch any messups on my part.

Very cool, thank you very much!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit ce547cb41ed7662f70d0b07d4c7f7555ba130c61
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Mon Jul 1 00:04:14 2019 -0400

    rcu: Simplify rcu_note_context_switch exit from critical section
    
    Because __rcu_read_unlock() can be preempted just before the call to
    rcu_read_unlock_special(), it is possible for a task to be preempted just
    before it would have fully exited its RCU read-side critical section.
    This would result in a needless extension of that critical section until
    that task was resumed, which might in turn result in a needlessly
    long grace period, needless RCU priority boosting, and needless
    force-quiescent-state actions.  Therefore, rcu_note_context_switch()
    invokes __rcu_read_unlock() followed by rcu_preempt_deferred_qs() when
    it detects this situation.  This action by rcu_note_context_switch()
    ends the RCU read-side critical section immediately.
    
    Of course, once the task resumes, it will invoke rcu_read_unlock_special()
    redundantly.  This is harmless because the fact that a preemption
    happened means that interrupts, preemption, and softirqs cannot
    have been disabled, so there would be no deferred quiescent state.
    While ->rcu_read_lock_nesting remains less than zero, none of the
    ->rcu_read_unlock_special.b bits can be set, and they were all zeroed by
    the call to rcu_note_context_switch() at task-preemption time.  Therefore,
    setting ->rcu_read_unlock_special.b.exp_hint to false has no effect.
    
    Therefore, the extra call to rcu_preempt_deferred_qs_irqrestore()
    would return immediately.  With one possible exception, which is
    if an expedited grace period started just as the task was being
    resumed, which could leave ->exp_deferred_qs set.  This will cause
    rcu_preempt_deferred_qs_irqrestore() to invoke rcu_report_exp_rdp(),
    reporting the quiescent state, just as it should.  (Such an expedited
    grace period won't affect the preemption code path due to interrupts
    having already been disabled.)
    
    But when rcu_note_context_switch() invokes __rcu_read_unlock(), it
    is doing so with preemption disabled, hence __rcu_read_unlock() will
    unconditionally defer the quiescent state, only to immediately invoke
    rcu_preempt_deferred_qs(), thus immediately reporting the deferred
    quiescent state.  It turns out to be safe (and faster) to instead
    just invoke rcu_preempt_deferred_qs() without the __rcu_read_unlock()
    middleman.
    
    Because this is the invocation during the preemption (as opposed to
    the invocation just after the resume), at least one of the bits in
    ->rcu_read_unlock_special.b must be set and ->rcu_read_lock_nesting
    must be negative.  This means that rcu_preempt_need_deferred_qs() must
    return true, avoiding the early exit from rcu_preempt_deferred_qs().
    Thus, rcu_preempt_deferred_qs_irqrestore() will be invoked immediately,
    as required.
    
    This commit therefore simplifies the CONFIG_PREEMPT=y version of
    rcu_note_context_switch() by removing the "else if" branch of its
    "if" statement.  This change means that all callers that would have
    invoked rcu_read_unlock_special() followed by rcu_preempt_deferred_qs()
    will now simply invoke rcu_preempt_deferred_qs(), thus avoiding the
    rcu_read_unlock_special() middleman when __rcu_read_unlock() is preempted.
    
    Cc: rcu@vger.kernel.org
    Cc: kernel-team@android.com
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 187dc076c497..214e4689c29d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -313,15 +313,6 @@ void rcu_note_context_switch(bool preempt)
 				       ? rnp->gp_seq
 				       : rcu_seq_snap(&rnp->gp_seq));
 		rcu_preempt_ctxt_queue(rnp, rdp);
-	} else if (t->rcu_read_lock_nesting < 0 &&
-		   t->rcu_read_unlock_special.s) {
-
-		/*
-		 * Complete exit from RCU read-side critical section on
-		 * behalf of preempted instance of __rcu_read_unlock().
-		 */
-		rcu_read_unlock_special(t);
-		rcu_preempt_deferred_qs(t);
 	} else {
 		rcu_preempt_deferred_qs(t);
 	}

